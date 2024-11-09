// hive_manager.dart
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class HiveManager {
  static final HiveManager _instance = HiveManager._internal();

  factory HiveManager() => _instance;

  HiveManager._internal();

  Future<void> initHive() async {
    final appDocumentDir =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    await Hive.openBox<dynamic>('songs');
  }

  void cacheDataLocally(List<dynamic> data) async {
    var box = Hive.box<dynamic>('songs');
    await box.put('songList', data);
  }

  void updateLocalData(dynamic data) async {
    var box = Hive.box<dynamic>('songs');
    List<dynamic> currentSongs =
        box.get('songList', defaultValue: []) as List<dynamic>;
    currentSongs
        .add(data); // Assuming data is structured correctly for your use case
    await box.put('songList', currentSongs);
  }

  List<dynamic> readCachedData() {
    var box = Hive.box<dynamic>('songs');
    return box.get('songList', defaultValue: []) as List<dynamic>;
  }

  void dispose() {
    Hive.close();
  }
}
