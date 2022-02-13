import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:napster_bloc/src/cubit/artistlist_cubit.dart';
import 'package:napster_bloc/src/global/common_params.dart';

import 'artists_list_widget.dart';

class ArtistListTop extends StatefulWidget {
  const ArtistListTop({
    Key? key,
  }) : super(key: key);

  @override
  _ArtistListTopState createState() => _ArtistListTopState();
}

class _ArtistListTopState extends State<ArtistListTop> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        BlocProvider.of<ArtistlistCubit>(context).getTopArtists();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArtistlistCubit, ArtistlistState>(
      builder: (context, state) {
        if (state is ArtistList) {
          if (state.artistlist.isEmpty) {
            return const Expanded(
                child: Center(
              child: MyCircularProgressIndicator(),
            ));
          }

          return ArtistsListWidget(
              controller: _controller,
              listArtists: state.artistlist,
              pageStorageKey: CommonParams.gridViewPageStorKey);
        }
        return const Center(
            child: Text(
                'Подождите пожалуйста. \n Отбираем для вас самых лучших артистов!'));
      },
    );
  }
}

class MyCircularProgressIndicator extends StatelessWidget {
  const MyCircularProgressIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Padding(
      padding: EdgeInsets.all(8.0),
      child: SizedBox(
          height: 28.0, width: 28.0, child: CircularProgressIndicator()),
    ));
  }
}
