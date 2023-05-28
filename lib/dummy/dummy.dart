import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testdeltasoft/dummy/widgets/unfocusable.dart';
import 'package:video_player/video_player.dart';

import 'constants.dart';
import 'controller.dart';

class Dummy extends StatefulWidget {
  const Dummy({super.key});

  static final opponentMovesList = <Map<String, dynamic>>[
    {
      'id': 0,
      'name': 'Scissors',
      'asset': 'assets/scissors.mp4',
    },
    {
      'id': 1,
      'name': 'Rock',
      'asset': 'assets/rock.mp4',
    },
    {
      'id': 2,
      'name': 'Paper',
      'asset': 'assets/paper.mp4',
    },
  ];

  static final myMovesList = <Map<String, dynamic>>[
    {
      'id': 0,
      'name': 'Scissors',
      'asset': 'assets/scissors_flipped.mp4',
    },
    {
      'id': 1,
      'name': 'Rock',
      'asset': 'assets/rock_flipped.mp4',
    },
    {
      'id': 2,
      'name': 'Paper',
      'asset': 'assets/paper_flipped.mp4',
    },
  ];

  @override
  State<Dummy> createState() => _DummyState();
}

class _DummyState extends State<Dummy> {
  final getxCtrl = Get.find<Controller>();

  VideoPlayerController? opponentController;
  VideoPlayerController? myController;

  int wins = 0;
  int losses = 0;

  List<bool> statisticsWin = [];

  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    opponentController?.dispose();
    myController?.dispose();
  }

  Future<void> startGame(Map<String, dynamic> myMove) async {
    setState(() {
      isLoading = true;
    });

    await opponentController?.dispose();
    await myController?.dispose();

    final opponentMovesListClone = [...Dummy.opponentMovesList];
    opponentMovesListClone.shuffle();
    final randomOpponentMove = opponentMovesListClone.first;

    opponentController = VideoPlayerController.asset(
      randomOpponentMove['asset']!,
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );
    myController = VideoPlayerController.asset(
      myMove['asset']!,
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );

    await opponentController!.setLooping(false);
    await opponentController!.setVolume(0.0);

    await myController!.setLooping(false);
    await myController!.setVolume(0.0);

    await opponentController!.play();
    await myController!.play();

    await opponentController!.initialize();
    await myController!.initialize();

    if (randomOpponentMove['id'] == 0 && myMove['id'] == 0) {
    } else if (randomOpponentMove['id'] == 0 && myMove['id'] == 1) {
      wins += 1;
      statisticsWin.add(true);
    } else if (randomOpponentMove['id'] == 0 && myMove['id'] == 2) {
      losses += 1;
      statisticsWin.add(false);
    } else if (randomOpponentMove['id'] == 1 && myMove['id'] == 0) {
      losses += 1;
      statisticsWin.add(false);
    } else if (randomOpponentMove['id'] == 1 && myMove['id'] == 1) {
    } else if (randomOpponentMove['id'] == 1 && myMove['id'] == 2) {
      wins += 1;
      statisticsWin.add(true);
    } else if (randomOpponentMove['id'] == 2 && myMove['id'] == 0) {
      wins += 1;
      statisticsWin.add(true);
    } else if (randomOpponentMove['id'] == 2 && myMove['id'] == 1) {
      losses += 1;
      statisticsWin.add(false);
    } else if (randomOpponentMove['id'] == 2 && myMove['id'] == 2) {}

    if (statisticsWin.length >= 3) {
      final last3IsFalse =
          statisticsWin.reversed.toList().sublist(0, 3).every((e) => !e);
      if (last3IsFalse) {
        wins = 0;
        losses = 0;
      }
    }

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async => false,
      child: UnFocusable(
        child: Scaffold(
          backgroundColor: Colors.white,
          extendBodyBehindAppBar: false,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Container(
              width: size.width,
              height: kToolbarHeight,
              alignment: Alignment.center,
              child: Row(
                children: [
                  Text(
                    'WINS: $wins',
                    style: GoogleFonts.abel(
                      color: Colors.green,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(width: 18.0),
                  Text(
                    'LOSSES: $losses',
                    style: GoogleFonts.abel(
                      color: Colors.redAccent,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  setState(() {
                    opponentController = null;
                    myController = null;

                    wins = 0;
                    losses = 0;
                  });
                },
                icon: const Icon(Icons.question_mark),
                color: Colors.black,
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (isLoading)
                  Container(
                    alignment: Alignment.center,
                    height: size.height * .6,
                    child: const CircularProgressIndicator(),
                  )
                else if (opponentController != null &&
                    myController != null) ...[
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: SizedBox(
                      width: opponentController?.value.size.width,
                      height: opponentController?.value.size.height,
                      child: VideoPlayer(opponentController!),
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: SizedBox(
                      width: myController?.value.size.width,
                      height: myController?.value.size.height,
                      child: VideoPlayer(myController!),
                    ),
                  ),
                ] else
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        Text(
                          Texts.mainTitle,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.actor(
                            color: Colors.black,
                            fontSize: 28.0,
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
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 32.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    children: List.generate(Dummy.myMovesList.length, (index) {
                      final item = Dummy.myMovesList.elementAt(index);

                      return Expanded(
                        child: GestureDetector(
                          onTap: () => startGame(item),
                          child: Container(
                            height: 36.0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.amber,
                            ),
                            margin:
                                EdgeInsets.only(left: index == 0 ? 0.0 : 12.0),
                            child: Text(
                              item['name'].toString(),
                              style: GoogleFonts.actor(
                                color: Colors.black,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
