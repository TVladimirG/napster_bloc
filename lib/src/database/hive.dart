import 'package:hive_flutter/adapters.dart';
import 'package:napster_bloc/src/api/loading_tracks.dart';
import 'package:napster_bloc/src/models/tracks_model.dart';

class HiveDB {
  static void addTrack(Track track) {
    final Box box = Hive.box<Track>('favorit_tracks');
    if (!box.containsKey(track.id)) {
      track.addedCollection = DateTime.now();
      box.put(track.id, track);
    }
  }

  static void delTrack(Track track) {
    final Box box = Hive.box<Track>('favorit_tracks');
    if (!box.containsKey(track.id)) {
      box.delete(track.id);
    }
  }

  static Future<void> getAllTracks() async {
    final Box box = await Hive.openBox<Track>('favorit_tracks');

    final myCol = box.values.toList();
    for (Track item in myCol) {
      LoadTracks.getImageAlbum(item);
    }
  }
}
