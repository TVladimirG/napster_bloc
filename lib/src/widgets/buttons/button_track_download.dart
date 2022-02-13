import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:napster_bloc/src/global/enums.dart';
import 'package:napster_bloc/src/cubit/tracklist_cubit.dart';
import 'package:napster_bloc/src/models/artist_model.dart';

// Это просто кнопка, в карточке артиста, которая загружает следующие 5 треков текущего артиста
class ButtonTrackDownload extends StatelessWidget {
  final Artist currentArtist;

  const ButtonTrackDownload({
    Key? key,
    required this.currentArtist,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Кнопку не показываем, если идет загрузка
    return BlocBuilder<TracklistCubit, TracklistState>(
      builder: (context, state) {
        if (state is Tracklist && state.status == StateStatus.loading) {
          return const SliverToBoxAdapter(
            child: SizedBox(
              height: 24.0,
            ),
          );
        }

        //
        return SliverPadding(
          padding: const EdgeInsets.only(
              right: 80.0, left: 80.0, top: 8.0, bottom: 16.0),
          sliver: SliverToBoxAdapter(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black38,
                onPrimary: Colors.white,
                elevation: 0.0, // так лучше всего выглядит
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              onPressed: () {
                BlocProvider.of<TracklistCubit>(context)
                    .getTopTracksBloc(currentArtist: currentArtist);
              },
              child: const Text(
                'Загрузить еще',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
    );
  }
}
