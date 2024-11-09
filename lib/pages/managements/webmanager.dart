// web_socket_manager.dart
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import 'hive_manager.dart';

class WebSocketManager {
  static final WebSocketManager _instance = WebSocketManager._internal();
  io.Socket? socket;

  factory WebSocketManager() => _instance;

  WebSocketManager._internal() {
    connect();
  }

  void connect() {
    if (socket != null && socket!.connected) return;

    socket = io.io('http://192.168.219.101:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    socket!.onConnect((_) {
      if (kDebugMode) {
        print('Connected to WebSocket server');
      }
    });

    socket!.on('init', (data) {
      HiveManager().cacheDataLocally(data);
    });

    socket!.on('song_update', (data) {
      HiveManager().updateLocalData(data);
    });

    socket!.onError((data) {
      if (kDebugMode) {
        print('WebSocket Error: $data');
      }
    });

    socket!.onDisconnect((_) {
      if (kDebugMode) {
        print('Disconnected from WebSocket server');
      }
    });
  }

  void dispose() {
    if (socket != null) {
      socket!.disconnect();
    }
  }
}
