import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mi_ruta/constant.dart';
import 'package:mi_ruta/controllers/controller.dart';
import 'package:mi_ruta/widgets/logo_241.dart';

class DrawerMain extends StatelessWidget {
  const DrawerMain({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<Controller>(Controller());

    return Drawer(
      elevation: 16,
      shape: const BeveledRectangleBorder(
          borderRadius: BorderRadius.all(Radius.zero)),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            GestureDetector(
              child: const Logo241(),
              onTap: () {
                Get.toNamed("/");
              },
            ),
            ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                ListTile(
                    title: Text(
                      (controller.getIsAdmin())
                          ? 'Mi perfil (Admin)'
                          : 'Mi perfil',
                      style: GoogleFonts.readexPro(),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: secondaryText,
                      size: 20,
                    ),
                    dense: false,
                    onTap: () {
                      Get.toNamed("/profile");
                    }),
                GetX<Controller>(builder: (_) {
                  if (controller.getIsAdmin()) {
                    return ListView(
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      children: [
                        ListTile(
                            title: Text("Añadir chofer",
                                style: GoogleFonts.readexPro()),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              color: secondaryText,
                              size: 20,
                            ),
                            dense: false,
                            onTap: () {
                              Get.toNamed("/adding_chofer");
                            }),
                        ListTile(
                            title: Text("Añadir administrador",
                                style: GoogleFonts.readexPro()),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              color: secondaryText,
                              size: 20,
                            ),
                            dense: false,
                            onTap: () {
                              Get.toNamed("/profile");
                            }),
                      ],
                    );
                  }
                  return Container();
                }),
                ListTile(
                  title: Text(
                    'Acuerdos de Privacidad',
                    style: GoogleFonts.readexPro(),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: secondaryText,
                    size: 20,
                  ),
                  dense: false,
                  onTap: () {
                    Get.toNamed("/auth");
                  },
                ),
                ListTile(
                    title: Text(
                      'Términos y Condiciones',
                      style: GoogleFonts.readexPro(),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: secondaryText,
                      size: 20,
                    ),
                    dense: false,
                    onTap: () {
                      Get.toNamed("/auth");
                    }),
              ],
            ),
            Expanded(
              child: Container(),
            ),
            ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                ListTile(
                  title: Text(
                    'Más aplicaciones',
                    style: GoogleFonts.readexPro(),
                  ),
                  trailing: const Icon(
                    Icons.launch,
                    color: secondaryText,
                    size: 20,
                  ),
                  dense: false,
                  onTap: () {
                    Get.toNamed("/auth");
                  },
                ),
                ListTile(
                  title: Text(
                    'Cerrar Sesión',
                    style: GoogleFonts.readexPro(),
                  ),
                  trailing: const Icon(
                    Icons.exit_to_app,
                    color: secondaryText,
                    size: 20,
                  ),
                  dense: false,
                  onTap: () async {
                    await controller.signout();
                    Get.toNamed("/auth");
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
