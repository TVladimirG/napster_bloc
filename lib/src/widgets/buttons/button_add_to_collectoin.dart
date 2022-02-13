import 'package:flutter/material.dart';
import 'package:napster_bloc/src/database/hive.dart';
import 'package:napster_bloc/src/models/tracks_model.dart';

// Кнопка "В избранное"
class ShowButtonAddToCollectoin extends StatelessWidget {
  final Track currentTrack;

  final bool showBtnLike;
  const ShowButtonAddToCollectoin({
    Key? key,
    required this.currentTrack,
    this.showBtnLike = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!showBtnLike) {
      return const SizedBox(
        height: 0.0,
      );
    }
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.green[500],
          onPrimary: Colors.white,
          elevation: 0.0, // так лучше всего выглядит
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
        onPressed: () {
          HiveDB.addTrack(currentTrack);
        },
        child: const Text('В коллекцию'));
  }
}
