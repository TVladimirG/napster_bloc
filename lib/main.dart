import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:napster_bloc/src/app.dart';
import 'package:napster_bloc/src/cubit/artistlist_cubit.dart';
import 'package:napster_bloc/src/cubit/searchartists_cubit.dart';
import 'package:napster_bloc/src/cubit/tracklist_cubit.dart';
import 'package:napster_bloc/src/database/hive.dart';
import 'package:napster_bloc/src/global/common_params.dart';
import 'package:napster_bloc/src/models/tracks_model.dart';
import 'package:napster_bloc/src/providers/current_artist.dart';
import 'package:napster_bloc/src/providers/error_net.dart';
import 'package:napster_bloc/src/settings/settings_controller.dart';
import 'package:napster_bloc/src/settings/settings_service.dart';
import 'package:provider/provider.dart';

void main() async {
  // в Hive будем хранить список любимых треков
  // Инициализируем Hive и адаптер
  await Hive.initFlutter();
  Hive.registerAdapter(TrackAdapter());
  // И за одно получим список треков
  await HiveDB.getAllTracks();

  await Hive.openBox<bool>('themedata');

  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<ArtistlistCubit>(
        create: (context) => ArtistlistCubit(),
      ),
      BlocProvider<TracklistCubit>(
        create: (context) => TracklistCubit(),
      ),
      BlocProvider<SearchArtistsCubit>(
        create: (context) => SearchArtistsCubit(),
      ),
      //  BlocProvider(
      //    create: (context) => SubjectBloc(),
      //  ),
    ],
    child: MultiProvider(
      providers: [
        // ChangeNotifierProvider<SearchArtistsProvider>(
        //     create: (context) => CommonParams.searchArtistsProvider),
        ChangeNotifierProvider<NetworkErrorProvider>(
            create: (context) => CommonParams.networkErrorProvider),
        ChangeNotifierProvider<CurrentArtist>(
            create: (context) => CommonParams.currentArtist),
      ],
      child: MyApp(settingsController: settingsController),
    ),
  ));
}
