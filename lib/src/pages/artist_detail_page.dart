import 'package:flutter/material.dart';
import 'package:napster_bloc/src/models/artist_model.dart';
import 'package:napster_bloc/src/pages/net_error.dart';
import 'package:napster_bloc/src/providers/current_artist.dart';
import 'package:napster_bloc/src/widgets/buttons/button_track_download.dart';
import 'package:napster_bloc/src/widgets/loading_indicators/loading_indicator_track.dart';
import 'package:napster_bloc/src/widgets/track_list.dart';
import 'package:provider/provider.dart';

class ArtistDetail extends StatelessWidget {
  static const routeName = '/ArtisrCard';
  // final Artist currentArtist;
  const ArtistDetail(
      //   this.currentArtist,
      {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Artist? currentArtist = context.read<CurrentArtist>().currentArtist;
    if (currentArtist == null) {
      return const NetError();
    }
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
                backgroundColor: Colors.black,
                expandedHeight: 237,
                pinned: true,
                elevation: 8.0,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: const EdgeInsets.all(16.0),
                  title: Container(
                      alignment: Alignment.bottomCenter,
                      child: Text(currentArtist.name)),
                  background: Hero(
                    tag: currentArtist.id,
                    child: Image(
                      image: currentArtist.imagePreview!.image,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                )),
            const SliverPadding(padding: EdgeInsets.all(4.0)),
            SliverPadding(
                padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    currentArtist.biography,
                    textAlign: TextAlign.justify,
                  ),
                )),
            //Список треков
            const TrackListWidget(),
            // Индикатор загрузки, выводится во время получения данных
            const SliverToBoxAdapter(child: TrackLoadingIndicator()),
            // Кнопка загрузки еще +5 ТОП треков
            ButtonTrackDownload(currentArtist: currentArtist),
          ],
        ),
      ),
    );
  }
}
