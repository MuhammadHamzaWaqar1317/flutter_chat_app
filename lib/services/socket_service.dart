import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:provider/provider.dart';
import 'package:chat_app_2/providers/chats_provider.dart';

class SocketService {
  static final SocketService _instance = SocketService._internal();

  late IO.Socket socket;

  factory SocketService() {
    return _instance;
  }

  SocketService._internal();


    void initSocket() {
      socket = IO.io('http://localhost:3000/', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      });
    socket.connect();

    socket.onConnect((_) {
      print('Socket connected');
      // socket.emit('connection'); // Register user with backend
    });

    socket.onDisconnect((_) => print('Socket disconnected'));

    socket.on('connection', (data) {
      print('Notification received: $data');
    });


  }

  void emit(String event, dynamic data) {
    socket.emit(event, data);
  }

  void on(String event, Function(dynamic) callback) {
    socket.on(event, callback);
  }

  void dispose() {
    socket.dispose();
  }
}
