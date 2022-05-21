import 'package:get/get.dart';
import 'package:librex/models/author_model.dart';

class AuthorController extends GetxController {
  final authorList = <AuthorModel>[].obs;

  @override
  void onInit() {
    authorList.bindStream(AuthorModel.getAllAuthorsByPub());
    super.onInit();
  }
}
