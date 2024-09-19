import 'package:flutter/material.dart';
import 'package:mi_ruta/constant.dart';
import 'package:mi_ruta/middleware/auth_middleware.dart';
import 'package:mi_ruta/pages/addingChofer.dart';
import 'package:mi_ruta/pages/auth.dart';
import 'package:mi_ruta/pages/home_page.dart';
import 'package:mi_ruta/pages/profile.dart';
import 'package:mi_ruta/pages/seguimiento.dart';
import 'package:mi_ruta/services/auth_service.dart';
import 'package:mi_ruta/services/geolocator_sevice.dart';
import 'package:mi_ruta/services/my_instance_service.dart';
import 'package:mi_ruta/services/web_socket_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get/get.dart';
import 'package:here_sdk/core.dart';
import 'package:here_sdk/core.engine.dart';
import 'package:here_sdk/core.errors.dart';

Future<void> main() async {
  // supabase initialize
  await Supabase.initialize(
    url: 'https://ppcgvrvckyxcuzrzxycv.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBwY2d2cnZja3l4Y3V6cnp4eWN2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjQ1OTk5NTgsImV4cCI6MjA0MDE3NTk1OH0.W-Yj_ZdBOFtz3kDFJBWGWKZE8buvp-5rNgGT7QDletg',
  );

  // services
  //Get.put(AuthService());
  await initServices();

  _initializeHERESDK();

  // runapp
  runApp(const MyApp());
}

void _initializeHERESDK() async {
  // Needs to be called before accessing SDKOptions to load necessary libraries.
  SdkContext.init(IsolateOrigin.main);

  // Set your credentials for the HERE SDK.
  String accessKeyId = "uQ57dpMCc950LBTSsBe5QA";
  String accessKeySecret =
      "USsNZvDOpUG3kvTYxQUA0zEdiWYAQNNQMIDQMfCOzcYVEOXSPeTqcNhaxRZlHhiSkGMjmyiQWV_xYSjyW49uQw";
  SDKOptions sdkOptions =
      SDKOptions.withAccessKeySecret(accessKeyId, accessKeySecret);

  try {
    await SDKNativeEngine.makeSharedInstance(sdkOptions);
  } on InstantiationException {
    throw Exception("Failed to initialize the HERE SDK.");
  }
}

Future<void> initServices() async {
  print('Servicios iniciando...');
  await Get.putAsync<AuthService>(() async => AuthService());
  await Get.putAsync<MyInstanceService>(() async => MyInstanceService());
  await Get.putAsync<WebSocketService>(() async => WebSocketService());
  await Get.putAsync<GeolocatorService>(() async => GeolocatorService());

  Get.find<AuthService>().start();
  print('Servicios iniciados');
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: appname,
      defaultTransition: Transition.native,
      //translations: MyTranslations(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        bottomAppBarTheme: const BottomAppBarTheme(color: Colors.white),
      ),
      initialRoute: '/',
      debugShowCheckedModeBanner: false,

      getPages: [
        GetPage(
            name: '/',
            page: () => const HomePage(),
            transition: Transition.fade,
            middlewares: [
              AuthMiddleware(),
            ]),
        GetPage(
          name: '/auth',
          page: () => const AuthPage(),
          transition: Transition.cupertino,
        ),
        GetPage(
          name: '/profile',
          page: () => const ProflePage(),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: '/adding_chofer',
          page: () => const AddingChoferPage(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: '/seguimiento',
          page: () => const SeguimientoPage(),
          transition: Transition.rightToLeft,
        ),
      ],
    );
  }
}
