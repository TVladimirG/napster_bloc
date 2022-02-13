import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:napster_bloc/src/settings/settings_view.dart';
import 'package:napster_bloc/src/widgets/artist_list_top.dart';
import 'package:napster_bloc/src/widgets/loading_indicators/loading_indicator.dart';

class ArtistsGrid extends StatelessWidget {
  static const routeName = '/ArtistsGrid';
  const ArtistsGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const childrenList = [
      ArtistListTop(),
      TopArtistLoadingIndicator(),
    ];

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.restorablePushNamed(context, SettingsView.routeName);
              },
              icon: const Icon(CupertinoIcons.settings))
        ],
        title: const Text('Популярные исполнители'),
      ),
      body: Column(
        children: childrenList,
      ),
    );
  }
}
