import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../controller.dart';

Future<void> showFullScreenDialog(
  BuildContext context, {
  required Map<String, dynamic> soccerPlayerData,
}) async {
  return showGeneralDialog<void>(
    context: context,
    pageBuilder: (BuildContext context, anim1, anim2) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
          ),
        ),
        body: _MainBody(soccerPlayerData: soccerPlayerData),
      );
    },
  );
}

class _MainBody extends StatefulWidget {
  const _MainBody({
    required this.soccerPlayerData,
  });

  final Map<String, dynamic> soccerPlayerData;

  @override
  State<_MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends State<_MainBody> {
  final controller = VideoPlayerController.asset('assets/box_animation.mp4');

  bool isQuestionOptionsReveal = false;

  String? selectedAnswerName;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      controller.setLooping(false);
      controller.setVolume(0.0);
      controller.play();
      await controller.initialize();

      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final getxCtrl = Get.find<Controller>();
    final size = MediaQuery.of(context).size;

    final dialogHeight = size.height;

    const optionTextStyle = TextStyle(fontSize: 16.0);

    return SingleChildScrollView(
      child: Container(
        width: size.width,
        constraints: BoxConstraints(
          maxHeight: dialogHeight,
        ),
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: controller.value.isInitialized
            ? SizedBox.expand(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Positioned(
                      top: 0,
                      child: AnimatedOpacity(
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeInOut,
                        opacity: isQuestionOptionsReveal ? 1.0 : 0.0,
                        child: Column(
                          children: [
                            Container(
                              width: size.width,
                              alignment: Alignment.center,
                              child: Text(
                                widget.soccerPlayerData['question'],
                                textAlign: TextAlign.center,
                                style: optionTextStyle.copyWith(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (selectedAnswerName == null) {
                                      if (widget.soccerPlayerData['options']
                                                  [0] ==
                                              widget.soccerPlayerData[
                                                  'correctAnswer'] &&
                                          !getxCtrl.correctAnswersIdList
                                              .contains(widget
                                                  .soccerPlayerData['id'])) {
                                        getxCtrl.correctAnswersIdList
                                            .add(widget.soccerPlayerData['id']);
                                      }
                                      setState(() {
                                        selectedAnswerName = widget
                                            .soccerPlayerData['options'][0];
                                      });
                                    }
                                  },
                                  child: Container(
                                    width: (size.width / 2) - 16.0,
                                    height: 45.0,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: selectedAnswerName == null
                                          ? Colors.transparent
                                          : widget.soccerPlayerData[
                                                      'correctAnswer'] ==
                                                  widget.soccerPlayerData[
                                                      'options'][0]
                                              ? Colors.greenAccent
                                              : selectedAnswerName ==
                                                      widget.soccerPlayerData[
                                                          'options'][0]
                                                  ? Colors.redAccent
                                                  : Colors.transparent,
                                      borderRadius: BorderRadius.circular(5.0),
                                      border: Border.all(color: Colors.black54),
                                    ),
                                    child: Text(
                                      widget.soccerPlayerData['options'][0],
                                      style: optionTextStyle,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 4.0),
                                GestureDetector(
                                  onTap: () {
                                    if (selectedAnswerName == null) {
                                      if (widget.soccerPlayerData['options']
                                                  [1] ==
                                              widget.soccerPlayerData[
                                                  'correctAnswer'] &&
                                          !getxCtrl.correctAnswersIdList
                                              .contains(widget
                                                  .soccerPlayerData['id'])) {
                                        getxCtrl.correctAnswersIdList
                                            .add(widget.soccerPlayerData['id']);
                                      }
                                      setState(() {
                                        selectedAnswerName = widget
                                            .soccerPlayerData['options'][1];
                                      });
                                    }
                                  },
                                  child: Container(
                                    width: (size.width / 2) - 16.0,
                                    height: 45.0,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: selectedAnswerName == null
                                          ? Colors.transparent
                                          : widget.soccerPlayerData[
                                                      'correctAnswer'] ==
                                                  widget.soccerPlayerData[
                                                      'options'][1]
                                              ? Colors.greenAccent
                                              : selectedAnswerName ==
                                                      widget.soccerPlayerData[
                                                          'options'][1]
                                                  ? Colors.redAccent
                                                  : Colors.transparent,
                                      borderRadius: BorderRadius.circular(5.0),
                                      border: Border.all(color: Colors.black54),
                                    ),
                                    child: Text(
                                      widget.soccerPlayerData['options'][1],
                                      style: optionTextStyle,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (selectedAnswerName == null) {
                                      if (widget.soccerPlayerData['options']
                                                  [2] ==
                                              widget.soccerPlayerData[
                                                  'correctAnswer'] &&
                                          !getxCtrl.correctAnswersIdList
                                              .contains(widget
                                                  .soccerPlayerData['id'])) {
                                        getxCtrl.correctAnswersIdList
                                            .add(widget.soccerPlayerData['id']);
                                      }
                                      setState(() {
                                        selectedAnswerName = widget
                                            .soccerPlayerData['options'][2];
                                      });
                                    }
                                  },
                                  child: Container(
                                    width: (size.width / 2) - 16.0,
                                    height: 45.0,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: selectedAnswerName == null
                                          ? Colors.transparent
                                          : widget.soccerPlayerData[
                                                      'correctAnswer'] ==
                                                  widget.soccerPlayerData[
                                                      'options'][2]
                                              ? Colors.greenAccent
                                              : selectedAnswerName ==
                                                      widget.soccerPlayerData[
                                                          'options'][2]
                                                  ? Colors.redAccent
                                                  : Colors.transparent,
                                      borderRadius: BorderRadius.circular(5.0),
                                      border: Border.all(color: Colors.black54),
                                    ),
                                    child: Text(
                                      widget.soccerPlayerData['options'][2],
                                      style: optionTextStyle,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 4.0),
                                GestureDetector(
                                  onTap: () {
                                    if (selectedAnswerName == null) {
                                      if (widget.soccerPlayerData['options']
                                                  [3] ==
                                              widget.soccerPlayerData[
                                                  'correctAnswer'] &&
                                          !getxCtrl.correctAnswersIdList
                                              .contains(widget
                                                  .soccerPlayerData['id'])) {
                                        getxCtrl.correctAnswersIdList
                                            .add(widget.soccerPlayerData['id']);
                                      }
                                      setState(() {
                                        selectedAnswerName = widget
                                            .soccerPlayerData['options'][3];
                                      });
                                    }
                                  },
                                  child: Container(
                                    width: (size.width / 2) - 16.0,
                                    height: 45.0,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: selectedAnswerName == null
                                          ? Colors.transparent
                                          : widget.soccerPlayerData[
                                                      'correctAnswer'] ==
                                                  widget.soccerPlayerData[
                                                      'options'][3]
                                              ? Colors.greenAccent
                                              : selectedAnswerName ==
                                                      widget.soccerPlayerData[
                                                          'options'][3]
                                                  ? Colors.redAccent
                                                  : Colors.transparent,
                                      borderRadius: BorderRadius.circular(5.0),
                                      border: Border.all(color: Colors.black54),
                                    ),
                                    child: Text(
                                      widget.soccerPlayerData['options'][3],
                                      style: optionTextStyle,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: SizedBox(
                        width: controller.value.size.width,
                        height: controller.value.size.height,
                        child: VideoPlayer(controller),
                      ),
                    ),
                    AnimatedContainerWidget(
                      dialogHeight: dialogHeight,
                      isRightAnswer: selectedAnswerName == null
                          ? null
                          : selectedAnswerName ==
                              widget.soccerPlayerData['correctAnswer'],
                      soccerPlayerData: widget.soccerPlayerData,
                      cardclickCallback: () {
                        setState(() {
                          isQuestionOptionsReveal = true;
                        });
                      },
                    ),
                  ],
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}

class AnimatedContainerWidget extends StatefulWidget {
  const AnimatedContainerWidget({
    super.key,
    required this.dialogHeight,
    required this.isRightAnswer,
    required this.soccerPlayerData,
    required this.cardclickCallback,
  });

  final double dialogHeight;
  final bool? isRightAnswer;
  final Map<String, dynamic> soccerPlayerData;
  final VoidCallback cardclickCallback;

  @override
  _AnimatedContainerWidgetState createState() =>
      _AnimatedContainerWidgetState();
}

class _AnimatedContainerWidgetState extends State<AnimatedContainerWidget> {
  bool hasAppeared = false;
  bool hasFlipped = false;
  bool hasRightGone = false;
  bool hasWrongGone = false;

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
  void didUpdateWidget(covariant AnimatedContainerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        if (mounted) {
          setState(() {
            if (widget.isRightAnswer != null) {
              if (widget.isRightAnswer!) {
                hasRightGone = true;
              } else {
                hasWrongGone = true;
              }
            }
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
          ? Matrix4.translationValues(
              hasRightGone
                  ? cardWidth
                  : hasWrongGone
                      ? -size.width
                      : 0,
              -(hasRightGone
                  ? widget.dialogHeight
                  : (widget.dialogHeight * .75) - cardHeight),
              0,
            )
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
                          // Navigator.of(context).push(pageTransition(
                          //     ContentDetailsPage(
                          //         soccerPlayerData: widget.soccerPlayerData)));
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
                        widget.cardclickCallback();
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
    final rotateAnim = Tween(begin: math.pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(hasFlipped) != widget!.key);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        final value = isUnder
            ? math.min(rotateAnim.value, math.pi / 2)
            : rotateAnim.value;
        return Transform(
          transform: Matrix4.rotationY(value)..setEntry(3, 0, tilt),
          alignment: Alignment.center,
          child: widget,
        );
      },
    );
  }
}
