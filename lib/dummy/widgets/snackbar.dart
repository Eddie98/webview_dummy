import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showSnackbar({
  required BuildContext context,
  required String text,
}) {
  final size = MediaQuery.of(context).size;

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      shape: const RoundedRectangleBorder(),
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      content: SizedBox(
        width: size.width,
        height: size.height,
        child: Center(
          child: Container(
            width: size.width,
            height: 45.0,
            margin: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 46, 46, 46),
              borderRadius: BorderRadius.circular(8.0),
            ),
            alignment: Alignment.center,
            child: Text(
              text,
              style: GoogleFonts.actor(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
