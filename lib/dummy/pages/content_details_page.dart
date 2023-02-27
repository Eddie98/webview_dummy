import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';

class ContentDetailsPage extends StatelessWidget {
  const ContentDetailsPage({
    super.key,
    required this.htmlString,
    required this.image,
  });

  final String htmlString;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(0.0, 132.0, 0.0, 32.0),
        child: Column(
          children: [
            Image.asset(image),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
              child: HtmlWidget(
                htmlString,
                textStyle: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
                onTapUrl: (url) async => false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
