import 'package:get/get.dart';
import 'package:librex/handlers/tag_hanlder.dart';

class TagController extends GetxController {
  var tagList = <String>[].obs;
  @override
  void onInit() {
    tagList.bindStream(TagHandler.instance.getTagList());
    super.onInit();
  }
}
