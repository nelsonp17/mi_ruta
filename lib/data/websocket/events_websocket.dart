import 'package:get/get.dart';
import 'package:mi_ruta/services/my_instance_service.dart';
import 'package:mi_ruta/services/web_socket_service.dart';

class EventsWebsocket {
  final myInstanceService = Get.find<MyInstanceService>();
  late WebSocketService webSocketService;

  EventsWebsocket(this.webSocketService);

  dynamic connect(dynamic data) {
    if (data != null) {
      print('connect');
      print(data);
      try {
        myInstanceService.clientID = data['socket_id'];
      } catch (e) {
        print(e);
      }
      webSocketService.isRunning.value = true;
    }
  }

  dynamic disconnect(dynamic data) {
    print('disconnect');
    webSocketService.isRunning.value = false;
  }

  dynamic error(dynamic data) {
    print('error');
    print(data);
  }

  dynamic client(dynamic data) {
    if (data != null) {
      print(data);
      try {
        print(data['socket_id']);
      } catch (e) {
        print(e);
      }
    }
  }

  dynamic drive(dynamic data) {
    print('error');
    print(data);
  }
}
