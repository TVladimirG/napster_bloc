import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:napster_bloc/src/cubit/tracklist_cubit.dart';
import 'package:napster_bloc/src/models/artist_model.dart';
import 'package:napster_bloc/src/pages/artist_detail_page.dart';
import 'package:napster_bloc/src/providers/current_artist.dart';

class ArtistsListWidget extends StatelessWidget {
  final ScrollController _controller;

  final List<Artist> listArtists;
  final PageStorageKey pageStorageKey;
  const ArtistsListWidget({
    Key? key,
    required ScrollController controller,
    required this.listArtists,
    required this.pageStorageKey,
  })  : _controller = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Center(
        child: GridView.builder(
          key: pageStorageKey,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          shrinkWrap: true,
          controller: _controller,
          itemCount: listArtists.length,
          itemBuilder: (BuildContext context, int index) {
            final Artist currentArtist = listArtists[index];

            return GestureDetector(
              onTap: () {
                // Если тапнули на артиста, тогда подчистим трек лист
                BlocProvider.of<TracklistCubit>(context).clearAll();
                // Установим текущего артиста
                context.read<CurrentArtist>().setCurrentArtist(currentArtist);
                // И наконец получим top треков
                BlocProvider.of<TracklistCubit>(context)
                    .getTopTracksBloc(currentArtist: currentArtist);

                Navigator.pushNamed(
                  context,
                  ArtistDetail.routeName,
                );

                // Все теперь поехали на новую страницу
              },
              child: Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    Hero(
                      tag: currentArtist.id,
                      child: Image(
                        height: 140.0,
                        image: currentArtist.imagePreview!.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        currentArtist.name,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
