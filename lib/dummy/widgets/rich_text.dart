import 'package:flutter/material.dart';

class RichTextWidget extends StatelessWidget {
  const RichTextWidget({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  static const textStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w400,
    color: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$title: ',
              style: textStyle.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: value,
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}
