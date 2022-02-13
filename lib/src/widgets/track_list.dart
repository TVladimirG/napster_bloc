import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:napster_bloc/src/cubit/tracklist_cubit.dart';
import 'package:napster_bloc/src/models/tracks_model.dart';
import 'package:napster_bloc/src/providers/error_net.dart';

import 'player/player.dart';

// Это список треков. Получает список треков из провайдера TrackListProvider и выводит их

class TrackListWidget extends StatelessWidget {
  const TrackListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Сначала получаем List с треками

    List<Track> _trackList = [];

    final _networkError = context.watch<NetworkErrorProvider>().networkError;

    if (_networkError) {
      return const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Text(
              'Ошибка получения данных из сети. Проверьте подключение к сети'),
        ),
      );
    }

    return BlocBuilder<TracklistCubit, TracklistState>(
      builder: (context, state) {
        if (state is Tracklist) {
          _trackList = state.tracklist;

          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final currentTrack = _trackList[index];

                return GestureDetector(
                  onTap: () {
                    // Открываем плеер и проигрываем текущий трек
                    playCurrentTrack(context, currentTrack);
                  },
                  // Выводим карточку с треком и информацией по нему
                  child: Card(
                    child: ListTile(
                      // Картинку альбома
                      leading: currentTrack.imagePreview,
                      // Наименование альбома
                      subtitle: Text(
                        'Album ${currentTrack.albumName}',
                        overflow: TextOverflow.fade,
                      ),
                      // Наименование трека
                      title: Text(
                        currentTrack.name,
                        overflow: TextOverflow.fade,
                      ),
                      // И просто для красоты картинку
                      trailing: const Icon(Icons.play_circle_outline),
                    ),
                  ),
                );
              },
              childCount: _trackList.length,
            ),
          );
        }
        //}
        return SliverToBoxAdapter(child: Container());
      },
    );
  }

  Future<dynamic> playCurrentTrack(BuildContext context, Track currentTrack) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Player(
          currentTrack,
          showBtnLike: true,
        );
      },
    );
  }
}
