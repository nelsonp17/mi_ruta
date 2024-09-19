import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mi_ruta/widgets/buttons/align_button.dart';
import 'package:mi_ruta/widgets/forms/custom_select.dart';
import 'package:mi_ruta/utils/validations.dart';
import 'package:mi_ruta/widgets/forms/text_form_field_custom.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class RegisterChoferForm extends StatefulWidget {
  const RegisterChoferForm({super.key});

  @override
  State<RegisterChoferForm> createState() => _RegisterChoferFormState();
}

class _RegisterChoferFormState extends State<RegisterChoferForm> {
  final formRegisterChoferKey = GlobalKey<FormState>();

  String email = "";
  String name = "";
  String telefono = "";
  String typeVehiculo = "";
  String placa = "";
  String cedula = "";
  String passwordDefault = "Ps8937546";
  String errorForm = "";

  void handleSend(BuildContext context) {
    void handleSuccess() {
      formRegisterChoferKey.currentState!.reset();
      Get.snackbar(
        'Exito',
        'Chofer insertado',
      );
    }

    void handleError() {
      Get.snackbar(
        'Error',
        errorForm,
      );
    }

    if (formRegisterChoferKey.currentState!.validate()) {
      formRegisterChoferKey.currentState!.save();
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
        await supabase.from("chofers").select("*").eq("email", email).limit(1);

    if (response.isNotEmpty) {
      setState(() {
        errorForm = "El chofer ya existe";
      });
      return false;
    }

    response =
        await supabase.from("users").select("*").eq("email", email).limit(1);

    if (response.isNotEmpty) {
      setState(() {
        errorForm = "El usuario ya existe";
      });
      return false;
    }

    try {
      await supabase.from('users').insert({
        'email': email,
        'name': name,
        'telefono': telefono,
        'cedula': cedula
      });
      await supabase.from('chofers').insert({
        'email': email,
        'vehiculo': typeVehiculo,
        'placa': placa,
        'activo': false,
        'suspendido': false
      });
    } catch (e) {
      print("ocurrio un error");
      print(e);
      setState(() {
        errorForm = e.toString();
      });
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formRegisterChoferKey,
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
                padding: const EdgeInsets.only(bottom: 16.0),
                child: TextFormFieldCustom(
                  labelText: 'Correo electrónico',
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.validateEmail,
                  onSaved: (value) {
                    email = value!;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: TextFormFieldCustom(
                    labelText: 'Nombre y Apellido',
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obligatorio';
                      }
                      return null; // Retorna null si la validación pasa
                    },
                    onSaved: (value) {
                      name = value!;
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: TextFormFieldCustom(
                    labelText: 'Cédula',
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obligatorio';
                      }
                      return null; // Retorna null si la validación pasa
                    },
                    onSaved: (value) {
                      cedula = value!;
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: TextFormFieldCustom(
                    labelText: 'Teléfono',
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obligatorio';
                      }
                      return null; // Retorna null si la validación pasa
                    },
                    onSaved: (value) {
                      telefono = value!;
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: TextFormFieldCustom(
                    labelText: 'N° de placa',
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obligatorio';
                      }
                      return null; // Retorna null si la validación pasa
                    },
                    onSaved: (value) {
                      placa = value!;
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: CustomSelect(
                  opciones: const ['Carro', 'Moto'],
                  valorSeleccionado: 'Carro', // Valor inicial
                  onChanged: (String value) {
                    print('Seleccionaste: $value');
                    typeVehiculo = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: AlignButton(
                  onPressed: () {
                    print('Button pressed ...');
                    handleSend(context);
                  },
                  text: 'Crear cuenta',
                ),
              ),
            ]));
  }
}
