import 'dart:io';

class NetworkService {
  static NetworkService instance = NetworkService._init();
  NetworkService._init();

  Future<bool> checkConnection() async {
    bool retval = false;

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        retval = true;
      }
    } on SocketException catch (_) {}
    return retval;
  }
}
