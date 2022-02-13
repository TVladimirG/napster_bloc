import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:napster_bloc/src/global/enums.dart';
import 'package:napster_bloc/src/cubit/tracklist_cubit.dart';

class TrackLoadingIndicator extends StatelessWidget {
  const TrackLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TracklistCubit, TracklistState>(
      builder: (context, state) {
        if (state is Tracklist) {
          if (state.status == StateStatus.loading) {
            return Column(
              children: const [
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 24.0, 0.0, 24.0),
                  child: LinearProgressIndicator(),
                ),
                Text('Подождите пожалуйста, идет загрузка треков...'),
              ],
            );
          }
        }

        return const SizedBox.shrink();
      },
    );
  }
}
