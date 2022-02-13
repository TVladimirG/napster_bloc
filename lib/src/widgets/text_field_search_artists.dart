import 'package:flutter/material.dart';

import 'buttons/button_search.dart';

// Текстовое поле, куда вводим текст для поиска.
// Это строка сначала текстовое поле, затем кнопка "Найти"

class TextFieldSearchArtists extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  TextFieldSearchArtists({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          // Текстовое поле для ввода запроса
          Flexible(
            flex: 3,
            child: Material(
              child: TextField(
                key: const Key('TextFieldSearch'),
                decoration: const InputDecoration(
                  labelText: 'Исполнитель',
                ),
                controller: _controller,
                keyboardType: TextInputType.name,
                onSubmitted: (value) {
                  FocusScope.of(context).unfocus();
                },
              ),
            ),
          ),
          // кнопка "Найти"
          Flexible(
            flex: 1,
            child: ButtonSearch(controller: _controller),
          )
        ],
      ),
    );
  }
}
