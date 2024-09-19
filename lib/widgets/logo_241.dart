import 'package:flutter/material.dart';
import 'package:mi_ruta/constant.dart';

class Logo241 extends StatelessWidget {
  const Logo241({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      logoUrl_241,
      width: 200,
      fit: BoxFit.cover,
    );
  }
}
