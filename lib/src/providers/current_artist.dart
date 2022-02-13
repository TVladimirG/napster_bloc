import 'package:flutter/material.dart';
import 'package:napster_bloc/src/models/artist_model.dart';

class CurrentArtist with ChangeNotifier {
  Artist? _currentArtist;

  Artist? get currentArtist => _currentArtist;

  setCurrentArtist(Artist? currentArtist) {
    _currentArtist = currentArtist;

    notifyListeners();
  }
}
