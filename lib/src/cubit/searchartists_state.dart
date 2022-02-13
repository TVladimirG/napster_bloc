part of 'searchartists_cubit.dart';

@immutable
abstract class SearchArtistsState {
  const SearchArtistsState();
}

@immutable
class SearchArtistsInitial extends SearchArtistsState {
  const SearchArtistsInitial(StateStatus init) : super();
}

@immutable
class SearchArtistList extends SearchArtistsState {
  const SearchArtistList({
    this.status = StateStatus.init,
    this.artistlist = const <Artist>[],
  }) : super();

  final StateStatus status;
  final List<Artist> artistlist;

  SearchArtistList copyWith({
    StateStatus? status,
    List<Artist>? artistlist,
  }) {
    return SearchArtistList(
      status: status ?? this.status,
      artistlist: artistlist ?? this.artistlist,
    );
  }
}
