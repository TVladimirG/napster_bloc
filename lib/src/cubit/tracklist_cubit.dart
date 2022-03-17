import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:napster_bloc/src/api/loading_tracks.dart';
import 'package:napster_bloc/src/global/enums.dart';
import 'package:napster_bloc/src/models/artist_model.dart';
import 'package:napster_bloc/src/models/tracks_model.dart';

part 'tracklist_state.dart';

class TracklistCubit extends Cubit<TracklistState> {
  TracklistCubit() : super(const TracklistInitial(StateStatus.init));

  final List<Track> trackList = [];
  //final int limitTracks = 5;
  bool _loadingInProgress = false;

  void getTopTracksBloc({required Artist currentArtist}) async {
    if (_loadingInProgress) {
      return;
    }

    _loadingInProgress = true;

    emit(const Tracklist().copyWith(
      status: StateStatus.loading,
      tracklist: trackList,
    ));

    final List<Track> tmpList = await LoadTracks.getTopTracksBloc(
        artist: currentArtist, offset: trackList.length);

    trackList.addAll(tmpList);

    emit(const Tracklist().copyWith(
      status: StateStatus.loaded,
      tracklist: trackList,
    ));
    _loadingInProgress = false;
  }

  void clearAll() {
    trackList.clear();
    emit(const Tracklist().copyWith(
      status: StateStatus.loaded,
    ));
  }
}
