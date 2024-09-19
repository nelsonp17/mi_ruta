import 'package:flutter/material.dart';
import 'package:mi_ruta/widgets/buttons/button.dart';

class AlignButton extends Button {
  const AlignButton({
    super.key,
    required super.onPressed,
    required super.text,
    super.backgroundColor,
    super.textColor,
    super.border,
    super.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const AlignmentDirectional(0, 0),
      child: Button(
        onPressed: onPressed,
        text: text,
        backgroundColor: backgroundColor,
        textColor: textColor,
        border: border,
        elevation: elevation,
      ),
    );
  }
}
