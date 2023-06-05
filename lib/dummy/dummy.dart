import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testdeltasoft/dummy/constants.dart';
import 'package:testdeltasoft/dummy/widgets/unfocusable.dart';

import 'controller.dart';
import 'pages/all_items.dart';
import 'pages/several_items.dart';
import 'widgets/page_transition.dart';
import 'widgets/show_full_screen_dialog.dart';
import 'widgets/sliver_grid.dart';

class Dummy extends StatefulWidget {
  const Dummy({super.key});

  @override
  State<Dummy> createState() => _DummyState();
}

class _DummyState extends State<Dummy> {
  @override
  Widget build(BuildContext context) {
    final getxCtrl = Get.find<Controller>();
    final size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async => false,
      child: UnFocusable(
        child: Scaffold(
          backgroundColor: Colors.white,
          extendBodyBehindAppBar: false,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.black54,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(pageTransition(const SeveralItemsPage()));
                },
                icon: const Icon(Icons.check),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(pageTransition(const AllItemsPage()));
                },
                icon: const Icon(Icons.people),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    getxCtrl.correctAnswersIdList.clear();
                  });
                },
                icon: const Icon(Icons.replay_outlined),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                const SizedBox(height: 32.0),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12.0,
                    crossAxisSpacing: 12.0,
                    height: 200.0,
                  ),
                  padding: EdgeInsets.zero,
                  itemCount: getxCtrl.playersList.length,
                  itemBuilder: (_, int index) {
                    final item = getxCtrl.playersList.elementAt(index);

                    return GestureDetector(
                      onTap: () {
                        // final playersListClone = [...playersList];
                        // playersListClone.shuffle();

                        if (!getxCtrl.correctAnswersIdList
                            .contains(item['id'])) {
                          showFullScreenDialog(context, soccerPlayerData: item);
                        }
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/box_image.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
