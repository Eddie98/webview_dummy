import 'package:flutter/material.dart';

import '../widgets/rich_text.dart';

class ContentDetailsPage extends StatelessWidget {
  const ContentDetailsPage({
    super.key,
    required this.soccerPlayerData,
  });

  final Map<String, String> soccerPlayerData;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.black54,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              soccerPlayerData['image']!,
              width: size.width,
              fit: BoxFit.fitWidth,
            ),
            const SizedBox(height: 12.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                soccerPlayerData['name']!,
                style: const TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                soccerPlayerData['description']!,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            RichTextWidget(
              title: 'Height',
              value: soccerPlayerData['height']!,
            ),
            const SizedBox(height: 12.0),
            RichTextWidget(
              title: 'Weight',
              value: soccerPlayerData['weight']!,
            ),
            const SizedBox(height: 12.0),
            RichTextWidget(
              title: 'Team',
              value: soccerPlayerData['team']!,
            ),
            const SizedBox(height: 12.0),
            RichTextWidget(
              title: 'Red cards count',
              value: soccerPlayerData['redCardCounts']!,
            ),
            const SizedBox(height: 12.0),
            RichTextWidget(
              title: 'Yellow cards count',
              value: soccerPlayerData['yellowCardCounts']!,
            ),
            const SizedBox(height: 12.0),
            RichTextWidget(
              title: 'Goals count',
              value: soccerPlayerData['goalsCount']!,
            ),
            const SizedBox(height: 12.0),
            RichTextWidget(
              title: 'Goals count',
              value: soccerPlayerData['description']!,
            ),
          ],
        ),
      ),
    );
  }
}
