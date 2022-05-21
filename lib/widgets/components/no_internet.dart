import 'package:flutter/material.dart';
import 'package:librex/style/constraints.dart';
import 'package:lottie/lottie.dart';

class NoInterNetWidget extends StatefulWidget {
  final Function() trigger;
  const NoInterNetWidget({Key? key, required this.trigger}) : super(key: key);

  @override
  State<NoInterNetWidget> createState() => _NoInterNetWidgetState();
}

class _NoInterNetWidgetState extends State<NoInterNetWidget> {
  bool lottieLoaded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _header(),
          ...lottieLoaded
              ? [
                  const Text(
                    "Oops, No Internet Connection",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 28, vertical: 8),
                    child: Text(
                      "Make sure wifi or cellular data it's turned on and Try Again",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  RawMaterialButton(
                    onPressed: widget.trigger,
                    child: const Text(
                      "Try Again",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    fillColor: baseColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  )
                ]
              : [],
        ],
      ),
    );
  }

  Padding _header() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Lottie.asset(
        "assets/lottie/404_error_2.json",
        onLoaded: (s) {
          setState(() {
            lottieLoaded = true;
          });
        },
      ),
    );
  }
}
