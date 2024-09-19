import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mi_ruta/constant.dart';
import 'package:mi_ruta/controllers/controller.dart';
import 'package:mi_ruta/controllers/home_controller.dart';
import 'package:mi_ruta/widgets/drawer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = Get.put(HomeController());
  final rootController = Get.put(Controller());

  final scaffoldKey = GlobalKey<ScaffoldState>();

  double widthCardImg = 150;
  double heightCardImg = 100;

  @override
  void initState() {
    super.initState();
    rootController.init();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: secondaryBackground,
      drawer: const DrawerMain(),
      appBar: rootController.appbar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
              child: Text(
                'Seleccione su tipo de Transporte',
                textAlign: TextAlign.center,
                maxLines: 2,
                style: GoogleFonts.readexPro(
                    fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    color: secondaryBackground,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: InkWell(
                      onTap: () {
                        homeController.startServiceMiruta("Carro");
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                'https://ezxjdxoncucdyfjkpona.supabase.co/storage/v1/object/public/logo/mi%20ruta/car.png?t=2024-08-22T13%3A57%3A23.455Z',
                                width: widthCardImg,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: secondaryBackground,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: InkWell(
                    onTap: () {
                      homeController.startServiceMiruta("Moto");
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              'https://ezxjdxoncucdyfjkpona.supabase.co/storage/v1/object/public/logo/mi%20ruta/motorbike.png',
                              width: widthCardImg,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      homeController.handleClick();
                    },
                    child: const Text("WebSocket / Iniciar")),
                ElevatedButton(
                    onPressed: () {
                      homeController.handleClickDisconnect();
                    },
                    child: const Text("WebSocket / Desconectar")),
                ElevatedButton(
                    onPressed: () {
                      homeController.handleClickMessaje();
                    },
                    child: const Text("WebSocket / Mensaje")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
