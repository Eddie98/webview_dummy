import 'package:flutter/material.dart';
import 'package:testdeltasoft/dummy/widgets/page_transition.dart';

import '../constants.dart';
import '../widgets/sliver_grid.dart';
import 'content_details_page.dart';

class AllItemsPage extends StatelessWidget {
  const AllItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.black54,
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
        itemCount: soccerPlayersList.length,
        itemBuilder: (_, int index) {
          final item = soccerPlayersList[index];

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
