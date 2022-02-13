import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:napster_bloc/src/global/enums.dart';
import 'package:napster_bloc/src/cubit/searchartists_cubit.dart';
import 'package:napster_bloc/src/global/common_params.dart';

import 'artists_list_widget.dart';

class ArtistListSearch extends StatelessWidget {
  const ArtistListSearch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController _controller = ScrollController();

    return BlocBuilder<SearchArtistsCubit, SearchArtistsState>(
      builder: (context, state) {
        if (state is SearchArtistList) {
          if (state.status == StateStatus.loading) {
            return Center(
                child: Column(
              children: const [
                Padding(
                  padding: EdgeInsets.all(24.0),
                  child: CircularProgressIndicator(),
                ),
                Text('Это может занять несколько секунд'),
              ],
            ));
          }

          if (state.status == StateStatus.loaded) {
            if (state.artistlist.isEmpty) {
              return const Center(
                child: Text('Ничего не найдено.'),
              );
            }
            log('state.status == StateStatus.loaded');
            return ArtistsListWidget(
                controller: _controller,
                listArtists: state.artistlist,
                pageStorageKey: CommonParams.searchPageStorKey);
          }
        }
        return const Center(
          child: Text('Ничего не найдено.'),
        );
      },
    );
  }
}
