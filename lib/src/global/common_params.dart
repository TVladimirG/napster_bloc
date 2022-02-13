import "package:flutter/material.dart";
import 'package:napster_bloc/src/providers/current_artist.dart';
import 'package:napster_bloc/src/providers/error_net.dart';

class CommonParams {
  static final NetworkErrorProvider networkErrorProvider =
      NetworkErrorProvider();
  static final CurrentArtist currentArtist = CurrentArtist();

  static const PageStorageKey gridViewPageStorKey = PageStorageKey('GridView');
  static const PageStorageKey searchPageStorKey = PageStorageKey('SearchView');
  static const PageStorageKey pageCollectStorageKey = PageStorageKey('Collelt');
}
