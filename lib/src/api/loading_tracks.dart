import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:napster_bloc/src/global/common_params.dart';
import 'package:napster_bloc/src/models/artist_model.dart';
import 'package:napster_bloc/src/models/tracks_model.dart';

import 'api_string.dart';

class LoadTracks {
  // Получаем партию ТОП треков
  static Future<List<Track>> getTopTracksBloc(
      {required Artist artist, int offset = 5}) async {
    final List<Track> listTrack = [];

    dynamic decodeDataTracks;
    const int limitTracks = 5;
    if (offset > 5) {
      offset = 5;
    }
    // final int offsetTracks = CommonParams.trackListProvider.trackListLength();

    // http://api.napster.com/v2.2/artists/Art.28463069/tracks/top?apikey=YTkxZ_________Hjbzk4&limit=10&offset=5
    final String server =
        '$api/artists/${artist.id}/tracks/top?apikey=$apiKey&limit=${limitTracks.toString()}&offset=${offset.toString()}';

//    CommonParams.networkErrorProvider.networkError = false;
//    CommonParams.trackListProvider.startLoading();

    try {
      final response = await http.get(Uri.parse(server));
      decodeDataTracks = jsonDecode(response.body) as Map;
    } catch (e) {
      CommonParams.networkErrorProvider.networkError = true;
      //     CommonParams.networkErrorProvider.networkError = true;
      //     CommonParams.trackListProvider.finishedLoading();
      return listTrack;
    }

    final tracks = decodeDataTracks['tracks'];
    for (var item in tracks) {
      final Track track = Track.fromJson(item);

      await getImageAlbum(track);
      //   CommonParams.trackListProvider.addNewTrackToList(track: track);

      listTrack.add(track);
    }

    //  CommonParams.trackListProvider.finishedLoading();

    return listTrack;
  }

  // Получаем картинки альбомов конкретного трека
  static Future<void> getImageAlbum(Track track) async {
    //http://api.napster.com/v2.2/albums/Alb.54719066/images?apikey=YTkxZTR_____________jU4Yzk4

    dynamic _decodeDataImageAlbum;

    // Если это не новый трек (а например из коллекции) и если у него заполнен реквизит imageAlbumURL
    // то можно попытаться получить картинку из cach CachedNetworkImageProvider
    if (track.imageAlbumURL.isNotEmpty) {
      try {
        track.imagePreview = Image(
            image: CachedNetworkImageProvider(track.imageAlbumURL.toString()));
      } catch (e) {
        track.imagePreview = null;
      }

      return;
    }

    // Если пришли сюда, то это новый трек, и для него сначала нужно получить массив ссылок на альбомы
    final Uri _uri =
        Uri.parse('$api/albums/${track.albumId}/images?apikey=$apiKey');

    try {
      final responseImageAlbum = await http.get(_uri);
      _decodeDataImageAlbum = jsonDecode(responseImageAlbum.body) as Map;
    } catch (e) {
      CommonParams.networkErrorProvider.networkError = true;
      return;
    }

    // Получим ветку 'images'
    if (_decodeDataImageAlbum['images'] == null) {
      track.imagePreview = null;
      return;
    }

    // Список картинок альбомов
    final List _lstAlbums = _decodeDataImageAlbum['images'];

    // Вторая запись в ветке, картинка 70*70, нам она подходит
    track.imageAlbumURL = _lstAlbums[1]['url'];

    if (track.imageAlbumURL.isNotEmpty) {
      try {
        track.imagePreview = Image(
            image: CachedNetworkImageProvider(track.imageAlbumURL.toString()));
        return;
      } catch (e) {
        track.imagePreview = null;
        return;
      }
    }

    track.imagePreview = null;
  }
}
