import 'dart:developer';

import 'package:flutter/material.dart';

import 'artists_grid_page.dart';
import 'my_collection_page.dart';
import 'search_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = 'HomePage';
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _StateHomePage createState() => _StateHomePage();
}

class _StateHomePage extends State<HomePage> {
  static final List<Widget> _widgetOptions = <Widget>[
    // const MyStartPage(),
    const ArtistsGrid(),
    const SearchPage(),
    const MyCollection(),
  ];

  int _selectedIndex = 0;

  @override
  void initState() {
    log('initTopArtists');
    super.initState();
  }

  final List<BottomNavigationBarItem> _itemsBottNavBar =
      const <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.library_music),
      label: 'Исполнители',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: 'Поиск',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: 'Коллекции',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.green[600],
          onTap: _onItemTapped,
          items: _itemsBottNavBar,
        ),
        body: _widgetOptions[_selectedIndex]);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
