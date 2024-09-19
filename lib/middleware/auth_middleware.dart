import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mi_ruta/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthMiddleware extends GetMiddleware {
  final authService = Get.find<AuthService>();
  final supabase = Supabase.instance.client;

  @override
  RouteSettings? redirect(String? route) {
    final session = supabase.auth.currentSession;

    if (session != null) {
      //return super.redirect(route);
      return null;
    }

    return const RouteSettings(name: '/auth');
  }
}
