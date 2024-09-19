import 'package:mi_ruta/data/websocket/events_websocket.dart';
import 'package:mi_ruta/services/my_instance_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:get/get.dart';
import 'package:mi_ruta/constant.dart';
import 'package:socket_io_client/socket_io_client.dart';

class WebSocketService extends GetxService {
  final messageData = {'': ''}.obs;
  final myInstanceService = Get.find<MyInstanceService>();
  final isRunning = false.obs; // si esta corriendo el socket
  final isStart = false.obs; // si esta corriendo el socket
  late EventsWebsocket eventsWebsocket = EventsWebsocket(this);

  WebSocketService() {
    eventsWebsocket = EventsWebsocket(this);
  }

  IO.Socket socket = IO.io(
      socketserve,
      OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build());

  Future<void> connect() async {
    if (isRunning.value == true) return;
    socket.connect();
  }

  void sendMessageClient(Map<String, dynamic> message) {
    if (!isRunning.value) return;
    socket.emit('client', message);
  }

  void sendMessageDrive(Map<String, dynamic> message) {
    if (!isRunning.value) return;
    socket.emit('drive', message);
  }

  Future<void> disconnect() async {
    if (isRunning.value == false) return;
    socket.disconnect();
  }

  Future<void> start() async {
    if (isRunning.value == true) return;

    if (isStart.value == false) {
      // Lista de enventos
      socket.onConnect((data) => eventsWebsocket.connect(data));
      socket.onDisconnect((data) => eventsWebsocket.disconnect(data));
      socket.onError((error) => eventsWebsocket.error(error));
      socket.on('client', (data) => eventsWebsocket.client(data));
      socket.on('drive', (data) => eventsWebsocket.drive(data));

      isStart.value = true;
    }
  }

  /**Future<void> connect() async {
    if (!isRunning.value) return;
    channel = WebSocketChannel.connect(Uri.parse(wsClient));
    isRunning.value = true;
    channel!.stream.listen((message) {
      messageData.value = message;
    }, onDone: () {
      // Manejar la desconexion
    }, onError: (error) {
      // Manejar los errores
    });
  }

  void sendMessage(Map<String, dynamic> data) {
    if (!isRunning.value) return;
    String jsonMessage = jsonEncode(data);
    channel!.sink.add(jsonMessage);
  }

  void desconnect() {
    if (isRunning.value) return;
    channel?.sink.close();
    channel = null;
    isRunning.value = false;
  }**/
}
