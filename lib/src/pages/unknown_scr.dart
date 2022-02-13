import 'package:flutter/material.dart';

class UnknownScreen extends StatelessWidget {
  const UnknownScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Something went wrong...',
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
              overflow: TextOverflow.clip,
            ),
          ),
          Text(
            'Sorry',
            style: Theme.of(context).textTheme.headline5,
            textAlign: TextAlign.end,
            overflow: TextOverflow.clip,
          ),
          //SizedBox(height: 200, child: Image.asset('images/oops.png')),
        ],
      ),
    );
  }
}
