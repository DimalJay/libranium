import 'package:flutter/material.dart';

class AlphaSplashScreen extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final String logo;
  final String appname;
  const AlphaSplashScreen(
      {Key? key,
      required this.child,
      required this.duration,
      required this.logo,
      required this.appname})
      : super(key: key);

  @override
  State<AlphaSplashScreen> createState() => _AlphaSplashScreenState();
}

class _AlphaSplashScreenState extends State<AlphaSplashScreen> {
  @override
  void initState() {
    Future.delayed(widget.duration).then((value) => Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => widget.child)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _splashContent(),
    );
  }

  Column _splashContent() {
    return Column(
      children: [_splashLogo(), _splashMetaData(), _splashCopyrights()],
    );
  }

  Padding _splashCopyrights() {
    return Padding(
        padding: const EdgeInsets.only(bottom: 16.0, top: 4.0),
        child: Text("© All Right Reserved ${DateTime.now().year}",
            style: const TextStyle(fontSize: 10)));
  }

  Text _splashMetaData() =>
      const Text("Developed by Alphabyte", style: TextStyle(fontSize: 12));

  Expanded _splashLogo() {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipOval(
                child: SizedBox(
                    width: 80, height: 80, child: Image.asset(widget.logo))),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                widget.appname,
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 141, 0, 66)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
