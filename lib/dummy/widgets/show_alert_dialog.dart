import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';
import '../pages/content_details_page.dart';
import 'page_transition.dart';

Future<void> showAlertDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.transparent,
    builder: (BuildContext context) {
      return const AlertDialog(
        contentPadding: EdgeInsets.zero,
        elevation: 0.0,
        content: _MainBody(),
      );
    },
  );
}

class _MainBody extends StatefulWidget {
  const _MainBody();

  @override
  State<_MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends State<_MainBody> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final dialogHeight = size.height * .6;

    return SingleChildScrollView(
      child: Container(
        width: size.width,
        constraints: BoxConstraints(
          maxHeight: dialogHeight,
        ),
        color: Colors.white,
        child: Column(
          children: [
            Text(
              Texts.mainTitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.actor(
                color: Colors.black,
                fontSize: 32.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 22.0),
            Text(
              Texts.mainDescription,
              textAlign: TextAlign.center,
              style: GoogleFonts.actor(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedContainerWidget extends StatefulWidget {
  const AnimatedContainerWidget({
    super.key,
    required this.dialogHeight,
    required this.soccerPlayerData,
  });

  final double dialogHeight;
  final Map<String, String> soccerPlayerData;

  @override
  _AnimatedContainerWidgetState createState() =>
      _AnimatedContainerWidgetState();
}

class _AnimatedContainerWidgetState extends State<AnimatedContainerWidget> {
  bool hasAppeared = false;
  bool hasFlipped = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(milliseconds: 1900),
      () {
        if (mounted) {
          setState(() {
            hasAppeared = true;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final cardWidth = size.width / 2;
    final cardHeight = cardWidth * 1.5;

    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
      transform: hasAppeared
          ? Matrix4.translationValues(0, -(widget.dialogHeight - cardHeight), 0)
          : Matrix4.identity(),
      child: AnimatedOpacity(
        duration: const Duration(seconds: 1),
        opacity: hasAppeared ? 1.0 : 0.0,
        child: AnimatedScale(
          duration: const Duration(seconds: 1),
          scale: hasAppeared ? 1.0 : 0.0,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 1000),
            transitionBuilder: __transitionBuilder,
            layoutBuilder: (widget, list) =>
                Stack(children: [widget!, ...list]),
            switchInCurve: Curves.easeInBack,
            switchOutCurve: Curves.easeInBack.flipped,
            child: hasFlipped
                ? Image.asset(
                    widget.soccerPlayerData['image']!,
                    width: cardWidth,
                    height: cardHeight,
                    fit: BoxFit.cover,
                    frameBuilder:
                        (context, child, frame, wasSynchronouslyLoaded) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(pageTransition(
                              ContentDetailsPage(
                                  soccerPlayerData: widget.soccerPlayerData)));
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6.0),
                          child: child,
                        ),
                      );
                    },
                  )
                : GestureDetector(
                    onTap: () {
                      if (mounted) {
                        setState(() {
                          hasFlipped = true;
                        });
                      }
                    },
                    child: Image.asset(
                      'assets/card_back.png',
                      width: cardWidth,
                      height: cardHeight,
                      fit: BoxFit.contain,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget __transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(hasFlipped) != widget!.key);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        final value =
            isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: Matrix4.rotationY(value)..setEntry(3, 0, tilt),
          alignment: Alignment.center,
          child: widget,
        );
      },
    );
  }
}
