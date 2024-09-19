import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mi_ruta/constant.dart';
import 'package:mi_ruta/widgets/buttons/button.dart';
import 'package:mi_ruta/utils/validations.dart';
import 'package:mi_ruta/widgets/forms/text_form_field_custom.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class FormSignin extends StatefulWidget {
  const FormSignin({super.key});

  @override
  State<FormSignin> createState() => _FormSigninState();
}

class _FormSigninState extends State<FormSignin> {
  bool passwordVisibility = false;
  bool passwordCreateVisibility = false;
  bool passwordConfirmVisibility = false;

  final formSingInKey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  String errorForm = "";

  void handleSend(BuildContext context) {
    void handleSuccess() {
      formSingInKey.currentState!.reset();
      Get.toNamed("/");
    }

    void handleError() {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorForm)));
    }

    if (formSingInKey.currentState!.validate()) {
      formSingInKey.currentState!.save();
      // operacion supabase
      handleSupbase().then((response) {
        if (response) {
          handleSuccess();
        } else {
          handleError();
        }
      });
    }
  }

  Future<bool> handleSupbase() async {
    setState(() {
      errorForm = "";
    });
    var response =
        await supabase.from("users").select("*").eq("email", email).limit(1);

    if (response.isEmpty) {
      setState(() {
        errorForm = "El usuario no existe";
      });
      return false;
    }

    final AuthResponse res = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    final accessToken = res.session?.accessToken;
    if (accessToken!.isNotEmpty) {
      return true;
    }

    setState(() {
      errorForm = "Ah ocurrido un error";
    });
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const AlignmentDirectional(0, 0),
      child: Form(
          key: formSingInKey,
          child: Padding(
            padding:
                const EdgeInsetsDirectional.only(top: 12, start: 50, end: 50),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 24),
                  child: Text(
                    'Ingrese sus datos',
                    style: GoogleFonts.readexPro(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: TextFormFieldCustom(
                      autofocus: true,
                      autofillHints: const [AutofillHints.email],
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      validator: Validators.validateEmail,
                      onSaved: (value) {
                        email = value!;
                      },
                      labelText: 'Correo Electrónico',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: TextFormField(
                      autofocus: false,
                      autofillHints: const [AutofillHints.password],
                      obscureText: !passwordVisibility,
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        labelStyle: GoogleFonts.readexPro(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: alternate,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: primary,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: error,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: error,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        filled: true,
                        fillColor: secondaryBackground,
                        contentPadding: const EdgeInsets.only(
                            top: 24, bottom: 24, left: 24, right: 40),
                        suffixIcon: InkWell(
                          onTap: () => setState(
                            () => passwordVisibility = !passwordVisibility,
                          ),
                          focusNode: FocusNode(skipTraversal: true),
                          child: Icon(
                            passwordVisibility
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: secondaryText,
                            size: 18,
                          ),
                        ),
                      ),
                      style: GoogleFonts.readexPro(),
                      cursorColor: primary,
                      validator: Validators.validatePassword,
                      onSaved: (value) {
                        password = value!;
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(0, 0),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                    child: Button(
                      onPressed: () {
                        handleSend(context);
                      },
                      text: 'Iniciar Sesión',
                    ),
                  ),
                ),
              ],
            ),
          )),
    ).animate().fadeIn(duration: 500.ms);
  }
}
