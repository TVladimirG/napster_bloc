part of 'artistlist_cubit.dart';

@immutable
abstract class ArtistlistState {
  const ArtistlistState();
}

@immutable
class ArtistlistInitial extends ArtistlistState {
  const ArtistlistInitial(StateStatus init) : super();
}

@immutable
class ArtistList extends ArtistlistState {
  const ArtistList({
    this.status = StateStatus.init,
    this.artistlist = const <Artist>[],
  }) : super();

  final StateStatus status;
  final List<Artist> artistlist;

  ArtistList copyWith({
    StateStatus? status,
    List<Artist>? artistlist,
  }) {
    return ArtistList(
      status: status ?? this.status,
      artistlist: artistlist ?? this.artistlist,
    );
  }
}
