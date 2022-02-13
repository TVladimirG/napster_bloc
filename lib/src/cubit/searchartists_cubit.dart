import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:napster_bloc/src/api/loading_artists.dart';
import 'package:napster_bloc/src/global/enums.dart';
import 'package:napster_bloc/src/models/artist_model.dart';

part 'searchartists_state.dart';

class SearchArtistsCubit extends Cubit<SearchArtistsState> {
  SearchArtistsCubit() : super(const SearchArtistsInitial(StateStatus.init));

  final List<Artist> _artistList = [];
  bool _loadingInProgress = false;

  void clear() {
    _artistList.clear();
    emit(const SearchArtistList()
        .copyWith(status: StateStatus.loaded, artistlist: _artistList));
  }

  void searchArtists({required String searchString}) async {
    //log('searchString = $searchString');
    if (_loadingInProgress) {
      return;
    }
    _loadingInProgress = true;

    emit(const SearchArtistList()
        .copyWith(status: StateStatus.loading, artistlist: _artistList));

    final List<Artist> tmpList =
        await LoadArts.searchArtists(searchString: searchString);
    _artistList.addAll(tmpList);

    emit(const SearchArtistList()
        .copyWith(status: StateStatus.loaded, artistlist: _artistList));

    _loadingInProgress = false;
  }
}
