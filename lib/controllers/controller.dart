import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mi_ruta/constant.dart';
import 'package:mi_ruta/services/auth_service.dart';

class Controller extends GetxController {
  final authService = Get.find<AuthService>();

  var isAdmin = false.obs;
  bool getIsAdmin() => isAdmin.value;
  void setIsAdmin() => isAdmin.value = authService.isAdmin;

  var isChofer = false.obs;
  set setIsChofer(bool value) => isChofer.value = value;
  bool getIsChofer() => isChofer.value;

  Controller() {
    init();
  }

  // Inicialización del servicio
  Future<void> init() async {
    //await authService.start();
    setIsAdmin();
    setIsChofer = authService.isChofer;

    print(isAdmin);
    print(isChofer);
    update();
  }

  Future<void> signout() async {
    await authService.signout();
  }

  PreferredSizeWidget? appbar({String text = 'Inicio'}) {
    return AppBar(
      backgroundColor: primary,
      foregroundColor: Colors.white,
      automaticallyImplyLeading: true,
      title: Text(
        text,
        style: GoogleFonts.outfit(fontSize: 22, color: Colors.white),
      ),
      actions: const [],
      centerTitle: false,
      elevation: 2,
    );
  }
}
