//import 'package:flutter/material.dart';

// ignore: dangling_library_doc_comments
/**import 'package:mi_ruta/constant.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
//import 'package:web_socket_channel/status.dart' as status;

Future<WebSocketChannel> userWebsocket() async {
  final channel = WebSocketChannel.connect(
    Uri.parse(wsUser),
  );

  return channel;
}

void userWebsocketBackup() async {
  final channel = WebSocketChannel.connect(
    Uri.parse(wsUser),
  );

  await channel.ready;

  channel.sink.add("enviado");

  channel.stream.listen(
    (data) {
      print("La data ha sido recibida: $data");
      //channel.sink.close();
    },
    onError: (error) => print(error),
  );
}

**/
/**
 * 
 * Widget handleChannel(context, snapshot) {
    return Text(snapshot.hasData ? '${snapshot.data}' : "");
  }
StreamBuilder(
  key: streamBKey,
  builder: (context, snapshot) =>
      handleChannel(context, snapshot),
  stream: _channel.stream,
),




ejercicio 2: clock, cerrar websocket (stop) y iniciar websocket (start)

WebSocketChannel? _channel;
  String _currentTime = 'Sin comunicación';
  bool _isRunning = false;

  void _desconnect() {
    _channel?.sink.close();
    _channel = null;
  }

  void _connect() {
    _channel = WebSocketChannel.connect(
      Uri.parse(wsInsert),
    );
    _channel!.stream.listen((message) {
      setState(() {
        _currentTime = message;
      });
    });
  }

  void toggleTimer() {
    setState(() {
      _isRunning = !_isRunning;

      if (_isRunning) {
        _connect();
      } else {
        _desconnect();
      }
    });
  }

  ...

  Text(_currentTime),
  ElevatedButton(
      onPressed: toggleTimer,
      child: Text(_isRunning ? 'Stop' : 'Start')),




  ejercicio 3

  WebSocketChannel? _channel = WebSocketChannel.connect(
    Uri.parse(wsInsert),
  );
  String _currentTime = 'Sin comunicación';

  void _desconnect() {
    _channel?.sink.close();
    _channel = null;
  }

  void _connect() {
    _channel!.stream.listen((message) {
      setState(() {
        _currentTime = message;
      });
    });
  }

  void toggleTimer() {
    _channel!.sink.add('insert');
  }

  @override
  void initState() {
    super.initState();
    rootController.init();
    _connect();
  }

  @override
  void dispose() {
    super.dispose();
    _desconnect();
  }
      
  ...

  Text(_currentTime),
  ElevatedButton(
      onPressed: toggleTimer,
      child: Text("")),

**/