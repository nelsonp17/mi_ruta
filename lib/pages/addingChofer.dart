import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mi_ruta/constant.dart';
import 'package:mi_ruta/ui/forms/register_chofer.dart';
import 'package:mi_ruta/widgets/logo_241.dart';

class AddingChoferPage extends StatefulWidget {
  const AddingChoferPage({super.key});

  @override
  State<AddingChoferPage> createState() => _AddingChoferPageState();
}

class _AddingChoferPageState extends State<AddingChoferPage>
    with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  TabController? tabBarController;

  @override
  void initState() {
    super.initState();

    tabBarController = TabController(
      vsync: this,
      length: 1,
      initialIndex: 0,
    )..addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: secondaryBackground,
      body: SafeArea(
        top: true,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 8,
              child: Container(
                width: 100,
                height: double.infinity,
                decoration: const BoxDecoration(
                  color: secondaryBackground,
                ),
                alignment: const AlignmentDirectional(0, -1),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 44, 0, 0),
                        child: Container(
                          width: double.infinity,
                          constraints: const BoxConstraints(
                            maxWidth: 602,
                          ),
                          decoration: const BoxDecoration(
                            color: secondaryBackground,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(0),
                            ),
                          ),
                          alignment: const AlignmentDirectional(-1, 0),
                          child: Align(
                            alignment: const AlignmentDirectional(-1, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.arrow_back_rounded,
                                    color: primaryText,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                                const Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 0, 0, 0),
                                  child: Logo241(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 800,
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              16, 0, 16, 0),
                          child: Column(
                            children: [
                              Align(
                                alignment: const Alignment(-1, 0),
                                child: TabBar(
                                  isScrollable: true,
                                  labelColor: primaryText,
                                  unselectedLabelColor: secondaryText,
                                  labelPadding: const EdgeInsets.only(
                                      top: 16, bottom: 16, left: 16, right: 16),
                                  labelStyle: GoogleFonts.outfit(
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 24,
                                  ),
                                  unselectedLabelStyle: GoogleFonts.outfit(
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 24,
                                  ),
                                  dividerColor: Colors.transparent,
                                  indicatorColor: primary,
                                  indicatorWeight: 4,
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 18, 0, 12),
                                  tabs: const [
                                    Tab(
                                      text: 'Registrar Chofer',
                                    ),
                                  ],
                                  controller: tabBarController,
                                  onTap: (i) async {
                                    [() async {}, () async {}][i]();
                                  },
                                ),
                              ),
                              Expanded(
                                child: TabBarView(
                                  controller: tabBarController,
                                  children: [
                                    const Align(
                                      alignment: AlignmentDirectional(0, 0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.only(
                                            top: 12, start: 50, end: 50),
                                        child: RegisterChoferForm(),
                                      ),
                                    ).animate().fadeIn(duration: 500.ms),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
