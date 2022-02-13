import 'package:flutter/material.dart';

class MySplashWidget extends StatelessWidget {
  const MySplashWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(children: [
            Expanded(
              child: Center(
                child: Image.asset('assets/images/napsterlogo.png'),
              ),
            ),
            const Text('Made with Flutter'),
            const Text('Thesis'),
          ]),
        ),
      ),
    );
  }
}
