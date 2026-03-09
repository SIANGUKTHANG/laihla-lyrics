import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class WebSocketService {
  late io.Socket socket;

  void initializeSocket(String userId) {
    // Replace with your server address
    socket = io.io('https://laihlalyrics.itrungrul.com', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    // Connect to WebSocket server
    socket.connect();

    // Register user ID upon connection
    socket.onConnect((_) {
      socket.emit('register', userId); // Send userId to register
      if (kDebugMode) {
        print('$userId connected');
      }
    });


    // Handle disconnection
    socket.onDisconnect((_) {
      if (kDebugMode) {
        print('Disconnected from WebSocket server');
      }
    });
  }

  void sendMessage(String message) {
    // Emit message to the server if you want to send a message from the client
    socket.emit('message', message);
  }

  void dispose() {
    socket.dispose();
  }
}
