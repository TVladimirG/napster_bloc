import 'package:flutter/material.dart';
import 'package:napster_bloc/src/widgets/artist_list_search.dart';
import 'package:napster_bloc/src/widgets/buttons/button_clear_search.dart';
import 'package:napster_bloc/src/widgets/text_field_search_artists.dart';

import 'net_error.dart';

class SearchPage extends StatelessWidget {
  static const routeName = '/SearchPage';
  const SearchPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const ButtonClearSearch(),
      appBar: AppBar(
        title: const Text('Поиск исполнителей'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextFieldSearchArtists(),
          const ArtistListSearch(),
          const NetError(showButton: false),
          //  const SearchLoadingIndicator(),
        ],
      ),
    );
  }
}
