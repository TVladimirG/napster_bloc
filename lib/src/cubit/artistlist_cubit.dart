import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:napster_bloc/src/api/loading_artists.dart';
import 'package:napster_bloc/src/global/enums.dart';
import 'package:napster_bloc/src/models/artist_model.dart';

part 'artistlist_state.dart';

class ArtistlistCubit extends Cubit<ArtistlistState> {
  ArtistlistCubit() : super(const ArtistlistInitial(StateStatus.init)) {
    getTopArtists();
  }

  final List<Artist> artistlist = [];
  final int limitArtists = 10;
  bool _loadingInProgress = false;

  void getTopArtists() async {
    if (_loadingInProgress) {
      return;
    }

    _loadingInProgress = true;

    emit(const ArtistList().copyWith(
      status: StateStatus.loading,
      artistlist: artistlist,
    ));

    final List<Artist> artl =
        await LoadArts.getTopArtistsBloc(offset: artistlist.length);

    artistlist.addAll(artl);

    emit(const ArtistList()
        .copyWith(status: StateStatus.loaded, artistlist: artistlist));
    _loadingInProgress = false;
  }

  void clear() {
    artistlist.clear();
  }
}
