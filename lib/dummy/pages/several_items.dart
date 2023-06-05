import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testdeltasoft/dummy/widgets/page_transition.dart';

import '../controller.dart';
import '../widgets/sliver_grid.dart';
import 'content_details_page.dart';

class SeveralItemsPage extends StatelessWidget {
  const SeveralItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final getxCtrl = Get.find<Controller>();
    final size = MediaQuery.of(context).size;

    final items = getxCtrl.playersList
        .where((e) => getxCtrl.correctAnswersIdList.contains(e['id']))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.grey[600],
      ),
      body: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
          crossAxisCount: 2,
          mainAxisSpacing: 2.0,
          crossAxisSpacing: 2.0,
          height: 250.0,
        ),
        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 32.0),
        itemCount: items.length,
        itemBuilder: (_, int index) {
          final item = items[index];

          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                pageTransition(ContentDetailsPage(soccerPlayerData: item)),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(item['image']!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
