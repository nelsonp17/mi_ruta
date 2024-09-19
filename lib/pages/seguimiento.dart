/**import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
*/
library;

import 'package:get/get.dart';
import 'package:here_sdk/mapview.dart';
import 'package:mi_ruta/controllers/seguimiento_controller.dart';
import 'package:mi_ruta/widgets/drawer.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mi_ruta/constant.dart';

class SeguimientoPage extends StatefulWidget {
  const SeguimientoPage({super.key});

  @override
  State<SeguimientoPage> createState() => _SeguimientoPageState();
}

class _SeguimientoPageState extends State<SeguimientoPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final controller = Get.put(SeguimientoController());

  @override
  void initState() {
    super.initState();
    //controller.stopWatchTimer.onStartTimer();
  }

  @override
  void dispose() async {
    super.dispose();
    await controller.stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: secondaryBackground,
        drawer: const DrawerMain(),
        appBar: controller.appbar(text: "Seguimiento"),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 50, 20, 20),
                child: Text(
                  'Espere, su transporte viene en camino',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: GoogleFonts.readexPro(fontSize: 24),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                child: Text(
                  'Tipo transcurido',
                  textAlign: TextAlign.end,
                  maxLines: 2,
                  style: GoogleFonts.readexPro(fontSize: 14),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
                child: StreamBuilder<int>(
                  stream: controller.stopWatchTimer.rawTime,
                  initialData: 0,
                  builder: (context, snap) {
                    final value = snap.data;
                    final displayTime = StopWatchTimer.getDisplayTime(value!);
                    controller.stopWatchTimer.onStartTimer();
                    return Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            displayTime,
                            style: GoogleFonts.readexPro(
                                fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            value.toString(),
                            style: GoogleFonts.readexPro(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                  child: HereMap(onMapCreated: controller.onMapCreated),
                ),
              ),

              /**
               * HereMap(onMapCreated: _onMapCreated)
               * Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                  child: FlutterFlowGoogleMap(
                    controller: _model.googleMapsController,
                    onCameraIdle: (latLng) => _model.googleMapsCenter = latLng,
                    initialLocation: _model.googleMapsCenter ??=
                        LatLng(13.106061, -59.613158),
                    markerColor: GoogleMarkerColor.violet,
                    mapType: MapType.normal,
                    style: GoogleMapStyle.standard,
                    initialZoom: 14,
                    allowInteraction: true,
                    allowZoom: true,
                    showZoomControls: true,
                    showLocation: true,
                    showCompass: false,
                    showMapToolbar: false,
                    showTraffic: false,
                    centerMapOnMarkerTap: true,
                  ),
                ),
              ),**/
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 7,
                        color: Color(0x2F1D2429),
                        offset: Offset(
                          0.0,
                          3,
                        ),
                      )
                    ],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(12, 8, 12, 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Icon(
                          Icons.mail_outline_outlined,
                          color: Color(0xFF4B39EF),
                          size: 32,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                12, 0, 8, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Contactar',
                                  style: GoogleFonts.plusJakartaSans(
                                      color: const Color(0xFF14181B),
                                      fontSize: 16,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w500),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 4, 0, 0),
                                  child: Text(
                                    '04242102539',
                                    style: GoogleFonts.plusJakartaSans(
                                        color: const Color(0xFF57636C),
                                        fontSize: 12,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        /**Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 4, 0),
                          child: FlutterFlowIconButton(
                            borderColor: const Color(0xFFE0E3E7),
                            borderRadius: 8,
                            borderWidth: 2,
                            buttonSize: 40,
                            icon: FaIcon(
                              FontAwesomeIcons.whatsapp,
                              color: const Color(0xFF57636C),
                              size: 20,
                            ),
                            onPressed: () {
                              print('IconButton pressed ...');
                            },
                          ),
                        ),**/
                        /**Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 4, 0),
                          child: FlutterFlowIconButton(
                            borderColor: const Color(0xFFE0E3E7),
                            borderRadius: 8,
                            borderWidth: 2,
                            buttonSize: 40,
                            icon: const Icon(
                              Icons.call,
                              color: Color(0xFF57636C),
                              size: 20,
                            ),
                            onPressed: () {
                              print('IconButton pressed ...');
                            },
                          ),
                        ),**/
                        /**FlutterFlowIconButton(
                          borderColor: const Color(0xFFE0E3E7),
                          borderRadius: 8,
                          borderWidth: 2,
                          buttonSize: 40,
                          icon: const Icon(
                            Icons.sms_sharp,
                            color: Color(0xFF57636C),
                            size: 20,
                          ),
                          onPressed: () {
                            print('IconButton pressed ...');
                          },
                        ),**/
                      ],
                    ),
                  ),
                ),
              ),
              const Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /** 
                  FFButtonWidget(
                    onPressed: () {
                      print('Button pressed ...');
                    },
                    text: 'Calificar',
                    icon: const Icon(
                      Icons.star,
                      size: 20,
                    ),
                    options: FFButtonOptions(
                      height: 40,
                      padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                      iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      color: Colors.white,
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'Readex Pro',
                                color: FlutterFlowTheme.of(context).primary,
                                letterSpacing: 0,
                              ),
                      elevation: 3,
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).primary,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                    child: FFButtonWidget(
                      onPressed: () {
                        print('Button pressed ...');
                      },
                      text: 'Cancelar',
                      icon: const Icon(
                        Icons.close_outlined,
                        color: Color(0xFFEC0E0E),
                        size: 24,
                      ),
                      options: FFButtonOptions(
                        height: 40,
                        padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                        iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        color: Colors.white,
                        textStyle:
                            FlutterFlowTheme.of(context).titleSmall.override(
                                  fontFamily: 'Readex Pro',
                                  color: const Color(0xFFEC0E0E),
                                  letterSpacing: 0,
                                ),
                        elevation: 3,
                        borderSide: const BorderSide(
                          color: Color(0xFFEC0E0E),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                
                  **/
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
