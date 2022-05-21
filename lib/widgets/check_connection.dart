import 'package:flutter/material.dart';
import 'package:librex/style/constraints.dart';

class CheckConnection extends StatelessWidget {
  final Future<bool> trigger;
  final Widget child;
  final Widget noInternet;
  const CheckConnection(
      {Key? key,
      required this.child,
      required this.noInternet,
      required this.trigger})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: trigger,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            bool _hasInternet = snapshot.data ?? false;
            if (_hasInternet) {
              return child;
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(color: baseColor));
          }
          return noInternet;
        });
  }
}
