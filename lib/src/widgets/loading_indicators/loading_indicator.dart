import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:napster_bloc/src/cubit/artistlist_cubit.dart';
import 'package:napster_bloc/src/global/enums.dart';

class TopArtistLoadingIndicator extends StatelessWidget {
  const TopArtistLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArtistlistCubit, ArtistlistState>(
      builder: (context, state) {
        if (state is ArtistList) {
          if (state.status == StateStatus.loading) {
            return const Padding(
              padding: EdgeInsets.fromLTRB(0.0, 24.0, 0.0, 24.0),
              child: LinearProgressIndicator(),
            );
          }
        }

        return const SizedBox.shrink();
      },
    );
  }
}
