import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:napster_bloc/src/cubit/searchartists_cubit.dart';

class ButtonSearch extends StatelessWidget {
  final TextEditingController _controller;

  const ButtonSearch({
    Key? key,
    required TextEditingController controller,
  })  : _controller = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.blue[400],
            onPrimary: Colors.white,
            elevation: 0.0, // так лучше всего выглядит
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
          onPressed: () {
            FocusScope.of(context).unfocus();
            BlocProvider.of<SearchArtistsCubit>(context)
                .searchArtists(searchString: _controller.text);
            // context
            //     .read<SearchArtistsProvider>()
            //     .searchArtists(searchString: _controller.text);
          },
          child: const Text('Найти')),
    );
  }
}
