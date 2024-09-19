import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mi_ruta/constant.dart';
import 'package:mi_ruta/widgets/buttons/profile_btn_list.dart';

class ProflePage extends StatefulWidget {
  const ProflePage({super.key});

  @override
  State<ProflePage> createState() => _ProflePageState();
}

class _ProflePageState extends State<ProflePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: ternaryBackground,
        appBar: AppBar(
          backgroundColor: secondaryBackground,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: primaryText,
              size: 30,
            ),
            onPressed: () {
              Navigator.pushNamed(context, "/");
            },
          ),
          title: Text(
            'Perfil',
            style: GoogleFonts.readexPro(),
          ),
          actions: const [],
          centerTitle: false,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 1, 0, 0),
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: secondaryBackground,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 3,
                        color: Color(0x33000000),
                        offset: Offset(
                          0,
                          1,
                        ),
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            color: accent2,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: secondary,
                              width: 2,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.network(
                                'https://images.unsplash.com/photo-1531123414780-f74242c2b052?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NDV8fHByb2ZpbGV8ZW58MHx8MHx8&auto=format&fit=crop&w=900&q=60',
                                width: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Joy Augustin',
                                style: GoogleFonts.outfit(fontSize: 24),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0, 4, 0, 0),
                                child: Text(
                                  'joy@augustin.com',
                                  style: GoogleFonts.readexPro(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 0, 0),
                child: Text(
                  'Mi cuenta',
                  style: GoogleFonts.readexPro(),
                ),
              ),
              ProfileBtnList(
                title: "Pagar suscripción",
                iconLeft: Icons.attach_money_rounded,
                onPressed: () {
                  print("Pagar suscripción");
                },
              ),
              ProfileBtnList(
                title: "Sistema de notificaciones",
                iconLeft: Icons.notifications_none,
                onPressed: () {
                  print("Sistema de notificaciones");
                },
              ),
              ProfileBtnList(
                title: "Editar foto",
                iconLeft: Icons.account_circle_outlined,
                onPressed: () {
                  print("Editar foto");
                },
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 0, 0),
                child: Text(
                  'Administrador',
                  style: GoogleFonts.readexPro(),
                ),
              ),
              ProfileBtnList(
                title: "Agregar chofer",
                iconLeft: Icons.local_taxi,
                onPressed: () {
                  Navigator.pushNamed(context, '/adding_chofer');
                },
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 0, 0),
                child: Text(
                  'General',
                  style: GoogleFonts.readexPro(),
                ),
              ),
              ProfileBtnList(
                title: "Soporte",
                iconLeft: Icons.help_outline_rounded,
                onPressed: () {
                  print("Soporte");
                },
              ),
              ProfileBtnList(
                title: "Térnimos de Seguridad",
                iconLeft: Icons.privacy_tip_rounded,
                onPressed: () {
                  print("Térnimos de Seguridad");
                },
              ),
              ProfileBtnList(
                title: "Inivitar un amigo",
                iconLeft: Icons.ios_share,
                onPressed: () {
                  print("Inivitar un amigo");
                },
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
