import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mi_ruta/constant.dart';

class CustomSelect extends StatefulWidget {
  final List<String> opciones;
  final String valorSeleccionado;
  final ValueChanged<String> onChanged;

  const CustomSelect({
    super.key,
    required this.opciones,
    required this.valorSeleccionado,
    required this.onChanged,
  });

  @override
  State<CustomSelect> createState() => _CustomSelectState();
}

class _CustomSelectState extends State<CustomSelect> {
  String? value;

  @override
  void initState() {
    super.initState();
    setState(() {
      value = widget.valorSeleccionado;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: alternate, width: 2),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: value,
            onChanged: (value) {
              setState(() => this.value = value);
              widget.onChanged(value!);
            },
            items: widget.opciones.map(buildMenuItem).toList(),
            isExpanded: true,
            icon: const Icon(Icons.arrow_drop_down, color: secondaryText),
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) =>
      DropdownMenuItem<String>(
        value: item,
        child: Text(
          item,
          style: GoogleFonts.readexPro(fontSize: 18, color: secondaryText),
        ),
      );
}
