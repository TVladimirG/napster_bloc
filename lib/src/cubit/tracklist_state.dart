part of 'tracklist_cubit.dart';

@immutable
abstract class TracklistState {
  const TracklistState();
}

@immutable
class TracklistInitial extends TracklistState {
  const TracklistInitial(StateStatus init) : super();
}

@immutable
class Tracklist extends TracklistState {
  const Tracklist({
    this.status = StateStatus.init,
    this.tracklist = const <Track>[],
  }) : super();

  final StateStatus status;
  final List<Track> tracklist;

  Tracklist copyWith({
    StateStatus? status,
    List<Track>? tracklist,
  }) {
    return Tracklist(
      status: status ?? this.status,
      tracklist: tracklist ?? this.tracklist,
    );
  }
}
