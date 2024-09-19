import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mi_ruta/constant.dart';

class ProfileBtnList extends StatelessWidget {
  final String title;
  final IconData iconLeft;
  final VoidCallback onPressed;
  const ProfileBtnList(
      {super.key,
      required this.title,
      required this.iconLeft,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: secondaryBackground,
          boxShadow: const [
            BoxShadow(
              blurRadius: 5,
              color: Color(0x3416202A),
              offset: Offset(
                0.0,
                2,
              ),
            )
          ],
          borderRadius: BorderRadius.circular(12),
          shape: BoxShape.rectangle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: InkWell(
            onTap: onPressed,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(
                  iconLeft,
                  color: secondaryText,
                  size: 24,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                    child: Text(
                      title,
                      style: GoogleFonts.readexPro(),
                    ),
                  ),
                ),
                const Align(
                  alignment: AlignmentDirectional(0.9, 0),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: secondaryText,
                    size: 18,
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
