import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:napster_bloc/src/global/common_params.dart';
import 'package:napster_bloc/src/models/artist_model.dart';

import 'api_string.dart';

class LoadArts {
  // Поиск артистов понаименованию и top артистов очень похожи - но есть отличия,
  // и чтобы не усложнять функцию, разобью её на 2 отдельные функции, пусть даже часть кода будет повторяться

  static Future<List<Artist>> getTopArtistsBloc({int offset = 10}) async {
    List<Artist> listArt = [];

    dynamic decodeDataArt;
    const int limitArtists = 10;
    final String server =
        '$api/artists/top?apikey=$apiKey&limit=${limitArtists.toString()}&offset=${offset.toString()}';

    try {
      // Получаем партию ТОП исполнителей
      final response = await http.get(Uri.parse(server));
      // Декодируем данные (попытаемся)
      decodeDataArt = jsonDecode(response.body) as Map;
    } catch (e) {
      //log('Ошибка загрузки артистов');
      CommonParams.networkErrorProvider.networkError = true;
      //CommonParams.artistListProvider.finishedLoading();
      return listArt;
    }

    final artists = decodeDataArt['artists'];

    await artistsFromJson(artists, listArt);
    // for (var item in artists) {
    //   final Artist currentArtist = Artist.fromJson(item);
    //   setBiography(currentArtist);

    //   currentArtist.imagePreview = Image.asset('assets/images/background.png');

    //   await getImageArtist(currentArtist);

    //   listArt.add(currentArtist);
    // }
    // Пометим как окончание процедуры загрузки
    return listArt;
  }

  // Поиск исполнителей по наименованию
  static Future<List<Artist>> searchArtists(
      {required String searchString}) async {
    List<Artist> listArt = [];
    if (searchString.isEmpty) {
      return listArt;
    }

    // Очистим предыдущие данные поиска
    //  CommonParams.searchArtistsProvider.clear();
    //  CommonParams.networkErrorProvider.networkError = false;
    //  CommonParams.searchArtistsProvider.startLoading();

    dynamic decodeDataArt;
    const int limitArtists = 50;
    final String server =
        '$api/search?apikey=$apiKey&per_type_limit=${limitArtists.toString()}&query=$searchString';

    try {
      final response = await http.get(Uri.parse(server));
      decodeDataArt = jsonDecode(response.body) as Map;
    } catch (e) {
      return listArt;
    }

    final artists = decodeDataArt['search']['data']['artists'];

    await artistsFromJson(artists, listArt);

    return listArt;
  }

  static Future<void> artistsFromJson(artists, List<Artist> listArt) async {
    for (var item in artists) {
      final Artist currentArtist = Artist.fromJson(item);
      setBiography(currentArtist);

      currentArtist.imagePreview = Image.asset('assets/images/background.png');

      await getImageArtist(currentArtist);

      listArt.add(currentArtist);
    }
  }

  static Future<void> getImageArtist(Artist currentArtist) async {
    try {
      final responseImage = await http.get(
          Uri.parse('$api/artists/${currentArtist.id}/images?apikey=$apiKey'));

      final decodeDataImage = jsonDecode(responseImage.body) as Map;

      // получим ветку 'images'
      final List lst = decodeDataImage['images'];
      // Первая запись в ветке, как раз имеет нормальный размер картинки, подходящий для многих случаев
      if (lst.isNotEmpty) {
        setArtistImage(artist: currentArtist, url: lst[0]['url']);
      }
    } catch (e) {
      currentArtist.imagePreview = Image.asset('assets/images/background.png');
      // Тут можно было бы установить пустую картинку, но мы это уже сделали заранее
    }
  }

  // Попробуем получить картинку из кэша, если нет, загрузим
  static void setArtistImage({required Artist artist, required String url}) {
    artist.imagePreview = Image(image: CachedNetworkImageProvider(url));
  }

  static void setBiography(Artist currentArtist) {
    String biography = '';
    try {
      biography = currentArtist.bios[0]['bio'];
    } catch (e) {
      biography = 'Работа над биографией еще не закончена.';
    }

    currentArtist.biography =
        biography.replaceAll(RegExp("<(\\S*?)[^>]*>.*?|<.*? />"), '');
  }
}
