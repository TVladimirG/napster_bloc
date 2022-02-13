import 'dart:io';

import 'package:flutter/cupertino.dart';

class NetworkErrorProvider with ChangeNotifier {
  bool _networkError = false;

  bool get networkError => _networkError;

  set networkError(bool networkError) {
    if (networkError != _networkError) {
      _networkError = !_networkError;
      notifyListeners();
    }
  }

  void checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        networkError = false;
        return;
      }
    } catch (e) {
      networkError = true;
      return;
    }

    networkError = true;
  }
}
