import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mi_ruta/constant.dart';

class Button extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final double? border;
  final double? elevation;

  const Button({
    super.key,
    required this.onPressed,
    required this.text,
    this.backgroundColor,
    this.textColor,
    this.border,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(230, 52),
        padding: EdgeInsets.zero,
        backgroundColor: backgroundColor ?? primary,
        elevation: elevation ?? 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(border ?? 40),
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.readexPro(
          color: textColor ?? Colors.white,
        ),
      ),
    );
  }
}
