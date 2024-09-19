import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:mi_ruta/services/web_socket_service.dart';

class GeolocatorService extends GetxService {
  late final realtimePosition = Position(
          longitude: 52.530932,
          latitude: 13.384915,
          timestamp: DateTime.now(),
          accuracy: 0,
          altitude: 0,
          altitudeAccuracy: 0,
          heading: 0,
          headingAccuracy: 0,
          speed: 0,
          speedAccuracy: 0)
      .obs;
  late final StreamSubscription<Position>? positionStream;
  final webSocketService = Get.find<WebSocketService>();
  final isRealtimePosition = false.obs;

  // Comprueba que el servicio y permiso de ubicacion esten activados
  Future<Position?> checkPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return null;
  }

  // determina la posicion
  Future<Position> determinePosition() async {
    final service = await checkPermission();
    if (service != null) return service;

    return await Geolocator.getCurrentPosition();
  }

  // ultima posicion conocida
  Future<Position?> lastPosition() async {
    return await Geolocator.getLastKnownPosition();
  }

  // Escuche actualizaciones de ubicación
  void startRealtimePosition() {
    // accuracy:la precisión de los datos de ubicación que su aplicación desea recibir;
    // distanceFilter:la distancia mínima (medida en metros) que un dispositivo debe moverse horizontalmente antes de que se genere un evento de actualización;
    if (isRealtimePosition.value == true) return;
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 5,
    );

    positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) {
      if (position == null) {
        print('Posición desconocida');
      } else {
        print(
            '${position.latitude.toString()}, ${position.longitude.toString()}');
        realtimePosition.value = position;
      }
    });
    isRealtimePosition.value = true;
  }

  void stopRealtimePosition() async {
    if (isRealtimePosition.value == false) return;
    if (positionStream != null) {
      await positionStream!.cancel();
    }
  }

  // Para calcular la distancia (en metros) entre dos coordenadas geográficas
  double distanceBetween(
      {required double lat1,
      required double long1,
      required double lat2,
      required double long2}) {
    // distanceInMeters
    return Geolocator.distanceBetween(lat1, long1, lat2, long2);
  }

  // calcular el rumbo entre dos coordenadas geográficas
  double bearingBetween(
      {required double lat1,
      required double long1,
      required double lat2,
      required double long2}) {
    // distanceInMeters
    return Geolocator.bearingBetween(lat1, long1, lat2, long2);
  }
}
