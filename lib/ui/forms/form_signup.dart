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

class FormSignup extends StatefulWidget {
  const FormSignup({super.key});

  @override
  State<FormSignup> createState() => _FormSignupState();
}

class _FormSignupState extends State<FormSignup> {
  bool passwordVisibility = false;
  bool passwordCreateVisibility = false;
  bool passwordConfirmVisibility = false;
  final formSingUpKey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  String confirm_password = "";
  String errorForm = "";

  bool _validatePassword() {
    if (password.isEmpty || confirm_password.isEmpty) {
      return false;
    }
    if (password != confirm_password) {
      return false;
    }
    return true;
  }

  void handleSend(BuildContext context) {
    void handleSuccess() {
      formSingUpKey.currentState!.reset();
      Get.toNamed("/");
    }

    void handleError() {
      // ocurrio un error
      print("ocurrio un error");
      print(errorForm);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorForm)));
    }

    if (formSingUpKey.currentState!.validate()) {
      formSingUpKey.currentState!.save();
      // operacion supabase
      handleSupbase().then((response) {
        if (response) {
          handleSuccess();
        } else {
          handleError();
        }
        print(response);
      });
    }
  }

  Future<bool> handleSupbase() async {
    setState(() {
      errorForm = "";
    });
    var response =
        await supabase.from("users").select("*").eq("email", email).limit(1);

    if (response.isNotEmpty) {
      setState(() {
        errorForm = "El usuario existe, inicie sesión";
      });
      return false;
    }

    await supabase.from('users').insert({'email': email});

    final res = await supabase.auth.signUp(
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
    return Form(
        key: formSingUpKey,
        child: Align(
          alignment: const AlignmentDirectional(0, 0),
          child: Align(
            alignment: const AlignmentDirectional(0, 0),
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
                        obscureText: !passwordCreateVisibility,
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
                          contentPadding: const EdgeInsets.all(24),
                          suffixIcon: InkWell(
                            onTap: () => setState(
                              () => passwordCreateVisibility =
                                  !passwordCreateVisibility,
                            ),
                            focusNode: FocusNode(skipTraversal: true),
                            child: Icon(
                              passwordCreateVisibility
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: secondaryText,
                              size: 24,
                            ),
                          ),
                        ),
                        style: GoogleFonts.readexPro(),
                        cursorColor: primary,
                        validator: Validators.validatePassword,
                        onSaved: (value) {
                          password = value!;
                        },
                        onChanged: (value) {
                          password = value;
                        },
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
                        obscureText: !passwordConfirmVisibility,
                        decoration: InputDecoration(
                          labelText: 'Confirme Contraseña',
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
                          contentPadding: const EdgeInsets.all(24),
                          suffixIcon: InkWell(
                            onTap: () => setState(
                              () => passwordConfirmVisibility =
                                  !passwordConfirmVisibility,
                            ),
                            focusNode: FocusNode(skipTraversal: true),
                            child: Icon(
                              passwordConfirmVisibility
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: secondaryText,
                              size: 24,
                            ),
                          ),
                        ),
                        style: GoogleFonts.readexPro(),
                        minLines: 1,
                        cursorColor: primary,
                        onSaved: (value) {
                          confirm_password = value!;
                        },
                        onChanged: (value) {
                          confirm_password = value;
                        },
                        validator: (value) {
                          if (confirm_password.isEmpty ||
                              _validatePassword() == false) {
                            return "Las constraseñas no coinciden";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Align(
                      alignment: const AlignmentDirectional(0, 0),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                        child: Button(
                          onPressed: () {
                            handleSend(context);
                          },
                          text: "Crear cuenta",
                        ),
                      )),
                ],
              ),
            ),
          ).animate().fadeIn(duration: 500.ms),
        ).animate().fadeIn(duration: 500.ms));
  }
}
