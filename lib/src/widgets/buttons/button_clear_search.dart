import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:napster_bloc/src/cubit/searchartists_cubit.dart';

class ButtonClearSearch extends StatelessWidget {
  const ButtonClearSearch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchArtistsCubit, SearchArtistsState>(
      builder: (context, state) {
        if (state is SearchArtistList) {
          if (state.artistlist.isEmpty) {
            return const SizedBox.shrink();
          }
          return IconButton(
            icon: const Icon(Icons.search_off),
            iconSize: 30.0,
            color: Colors.blue[400],
            onPressed: () {
              BlocProvider.of<SearchArtistsCubit>(context).clear();
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
