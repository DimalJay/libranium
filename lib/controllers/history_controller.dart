import 'package:get/get.dart';

class HistoryController extends GetxController {
  final historyList = <String>[].obs;

  void add(String text) {
    historyList.add(text);
  }
}
