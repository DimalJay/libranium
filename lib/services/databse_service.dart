import 'package:cloud_firestore/cloud_firestore.dart';

class FireDatabaseFeilds {
  static const String books = "books";
  static const String contents = "contents";
  static const String authors = "authors";

  static const String publishers = "publishers";
}

abstract class FireDatabasehanlder {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  final String collection;
  FireDatabasehanlder({required this.collection});

  Future<Future<DocumentSnapshot<Map<String, dynamic>>>> dbcreate(
      {required Map<String, dynamic> json}) async {
    return await _firebaseFirestore
        .collection(collection)
        .add(json)
        .then((value) => value.get());
  }

  Future<bool> dbupdate(
      {required String id, required Map<String, dynamic> json}) async {
    bool retVal = false;
    await _firebaseFirestore
        .collection(collection)
        .doc(id)
        .update(json)
        .then((value) => retVal = true);
    return retVal;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> dbreadCollection() {
    return _firebaseFirestore.collection(collection).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> dbreadCollectionOrderBy(
      String field) {
    return _firebaseFirestore.collection(collection).orderBy(field).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> dbreadCollectionByFilter(
      {required String field, String? isEqualTo}) {
    return _firebaseFirestore
        .collection(collection)
        .where(field, isEqualTo: isEqualTo)
        .snapshots();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> dbreadDoc(
      {required String id}) async {
    return await _firebaseFirestore
        .collection(collection)
        .doc(id)
        .get()
        .then((value) => value);
  }

  Future<bool> dbdelete({required String id}) async {
    bool retVal = false;
    await _firebaseFirestore
        .collection(collection)
        .doc(id)
        .delete()
        .then((value) => retVal = true);
    return retVal;
  }
}
