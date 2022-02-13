import 'package:flutter/cupertino.dart';
import 'package:napster_bloc/src/providers/error_net.dart';
import 'package:provider/provider.dart';

class NetError extends StatelessWidget {
  final bool showButton;
  const NetError({Key? key, this.showButton = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _networkError = context.watch<NetworkErrorProvider>().networkError;

    if (!_networkError) {
      return const SizedBox.shrink();
    }

    var children = <Widget>[
      const ErrText(),
    ];

    if (showButton) {
      children.add(
        const ErrButton(),
      );
    }

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }
}

class ErrButton extends StatelessWidget {
  const ErrButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton.filled(
      onPressed: () {
        context.read<NetworkErrorProvider>().checkInternet();

        // gNetworkErrorProvider.networkError = false;
      },
      child: const Text('Повторить попытку'),
    );
  }
}

class ErrText extends StatelessWidget {
  const ErrText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(24.0),
      child: Center(
        child: Text('Ошибка получения данных... Проверьте подключение к сети'),
      ),
    );
  }
}
