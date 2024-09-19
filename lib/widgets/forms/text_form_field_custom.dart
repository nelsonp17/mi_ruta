import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mi_ruta/constant.dart';

class TextFormFieldCustom extends StatefulWidget {
  const TextFormFieldCustom({
    super.key,
    required this.labelText,
    this.onSaved,
    required this.validator,
    this.keyboardType,
    this.autofillHints,
    this.autofocus = false,
    this.obscureText = false,
    this.isPassword = false,
    this.onChanged,
  });
  final String labelText;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType; // TextInputType.emailAddress
  final Iterable<String>? autofillHints; // const [AutofillHints.email]
  final bool autofocus; // true
  final bool obscureText;
  final bool isPassword;

  @override
  State<TextFormFieldCustom> createState() => _TextFormFieldCustomState();
}

class _TextFormFieldCustomState extends State<TextFormFieldCustom> {
  late bool passwordVisibility = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: widget.autofocus,
      autofillHints: widget.autofillHints,
      obscureText:
          (!widget.isPassword) ? widget.obscureText : !passwordVisibility,
      decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: GoogleFonts.readexPro(),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: alternate,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(40),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: primary,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(40),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: error,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(40),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: error,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(40),
          ),
          filled: true,
          fillColor: secondaryBackground,
          contentPadding: const EdgeInsets.all(24),
          suffix: (widget.isPassword == false)
              ? null
              : InkWell(
                  onTap: () => setState(
                    () => passwordVisibility = !passwordVisibility,
                  ),
                  focusNode: FocusNode(skipTraversal: true),
                  child: Icon(
                    passwordVisibility
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: secondaryText,
                    size: 24,
                  ),
                )),
      style: GoogleFonts.readexPro(),
      keyboardType: widget.keyboardType,
      cursorColor: primary,
      validator: widget.validator,
      onSaved: widget.onSaved,
      onChanged: widget.onChanged,
    );
  }
}
