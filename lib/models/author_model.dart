import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:librex/constraints.dart';
import 'package:librex/handlers/author_handler.dart';

class AuthorModelFeilds {
  static const String uid = "_uid";
  static const String dname = "_dname";
  static const String profilePIC = "_profilePIC";
  static const String pubID = "_pubID";
}

class AuthorModel {
  final String? id;
  final String uid; // User Id
  final String dname; // Display Name
  final String profilePIC;
  final String pubID;

  const AuthorModel(
      {this.id,
      required this.uid,
      required this.dname,
      required this.pubID,
      required this.profilePIC});

  static AuthorModel fromDocumentSnapshot(DocumentSnapshot doc) => AuthorModel(
        id: doc.id,
        uid: doc[AuthorModelFeilds.uid],
        dname: doc[AuthorModelFeilds.dname],
        profilePIC: doc[AuthorModelFeilds.profilePIC],
        pubID: doc[AuthorModelFeilds.pubID],
      );

  Map<String, dynamic> toJson() => {
        AuthorModelFeilds.uid: uid,
        AuthorModelFeilds.dname: dname,
        AuthorModelFeilds.profilePIC: profilePIC,
        AuthorModelFeilds.pubID: pubID,
      };

  AuthorModel copyWith({String? uid, String? dname, String? profilePIC}) =>
      AuthorModel(
        id: id,
        uid: uid ?? this.uid,
        dname: dname ?? this.dname,
        pubID: pubID,
        profilePIC: profilePIC ?? this.profilePIC,
      );

  // Database Oprations
  // Extend with Author Handler

  // @ Create Author
  Future<AuthorModel> createAuthor() =>
      AuthorHanlder.instance.createAuthor(this);

  // @ Update Author
  Future<bool> updateAuthor() => AuthorHanlder.instance.updateAuthor(this);

  // @ get Author by id
  static Future<AuthorModel> getAuthorById({required String id}) =>
      AuthorHanlder.instance.getAuthor(id);

  static Stream<List<AuthorModel>> getAllAuthorsByPub() =>
      AuthorHanlder.instance.getAuthorCollectionByFilter(
          feild: AuthorModelFeilds.pubID, value: Constants.pubID);

  // @ Delete Author
  Future<bool> deleteAuthor() =>
      AuthorHanlder.instance.deleteAuthor(id!).then((value) => value);
}
