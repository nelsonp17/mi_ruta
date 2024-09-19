import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:mi_ruta/services/auth_service.dart';
import 'package:mi_ruta/services/geolocator_sevice.dart';
import 'package:mi_ruta/services/my_instance_service.dart';
import 'package:mi_ruta/services/web_socket_service.dart';

class HomeController extends GetxController {
  final geolocatorService = Get.find<GeolocatorService>();
  final webSocketService = Get.find<WebSocketService>();
  final myInstanceService = Get.find<MyInstanceService>();
  final authService = Get.find<AuthService>();

  late final Rx<Position> position = Position(
          longitude: 0,
          latitude: 0,
          timestamp: DateTime.now(),
          accuracy: 0,
          altitude: 0,
          altitudeAccuracy: 0,
          heading: 0,
          headingAccuracy: 0,
          speed: 0,
          speedAccuracy: 0)
      .obs;

  void setPosition(Position value) {
    position.value = value;
  }

  // contrata el servicio de mi ruta, el cliente contacto a un taxis
  void startServiceMiruta(String vehiculo) async {
    // inicio el socket
    await webSocketService.start();

    // verifico los permisos de ubicacion y determino la ubicacion
    final position = await geolocatorService.determinePosition();

    // inicio el servicio de ubicación en tiempo real
    geolocatorService.startRealtimePosition();

    // ever se ejecuta cada vez que realtimePosition cambia
    // posiblemente muera al cambiar la pagina
    /**
    ever(geolocatorService.realtimePosition, (value) {
      print("cambio el valor realtimePosition $value");
    });**/

    // envio la informacion al websocket
    Map<String, dynamic> data = {
      'opc': "contract_service", // obligatorio a todas las peticiones al socket
      'client': {'email': authService.email},
      'vehiculo': vehiculo,
      'current_position': {'lat': position.latitude, 'long': position.longitude}
    };
    webSocketService.sendMessageClient(data);

    // redirigo
    Get.toNamed("seguimiento");
  }

  void handleClick() async {
    print("click");
    await webSocketService.start();
    await webSocketService.connect();
  }

  void handleClickDisconnect() async {
    print("click");
    await webSocketService.disconnect();
  }

  void handleClickMessaje() async {
    print("click");
    webSocketService.sendMessageClient({'message': 'Mensaje desde el cliente'});
  }
}
