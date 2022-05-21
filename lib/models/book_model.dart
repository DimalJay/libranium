import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:librex/handlers/book_handler.dart';

import 'content_model.dart';

class BookModelFeild {
  static const String title = "_title";
  static const String author = "_author";
  static const String cover = "_coverURL";
  static const String description = "_description";
  static const String dateNtime = "_timestamp";
  static const String content = "_content";
  static const String cid = "_cid";
  static const String tags = "_tags";
}

class BookModel {
  final String id;
  final String title;
  final String author;
  final String cover;
  final String description;
  final DateTime dateNtime;
  final ContentModel content;
  final List<String> tags;

  const BookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.cover,
    required this.description,
    required this.dateNtime,
    required this.content,
    required this.tags,
  });

  static BookModel fromDocumentSnapshot(DocumentSnapshot doc) {
    return BookModel(
      id: doc.id,
      title: doc[BookModelFeild.title],
      author: doc[BookModelFeild.author],
      cover: doc[BookModelFeild.cover],
      description: doc[BookModelFeild.description],
      dateNtime: DateTime.fromMicrosecondsSinceEpoch(
          doc[BookModelFeild.dateNtime] as int),
      content: ContentModel.fromBookSnapshotid(
        doc[BookModelFeild.cid],
      ),
      tags:
          doc[BookModelFeild.tags].map<String>((e) => e.toString()).toList() ??
              [],
    );
  }

  Map<String, dynamic> toJson() => {
        BookModelFeild.title: title,
        BookModelFeild.author: author,
        BookModelFeild.cover: cover,
        BookModelFeild.description: description,
        BookModelFeild.dateNtime: dateNtime.microsecondsSinceEpoch,
        BookModelFeild.cid: content.id,
        BookModelFeild.tags: tags,
      };

  BookModel copyWith(
          {String? title,
          String? author,
          String? cover,
          String? description,
          DateTime? dateNtime,
          List<String>? tags,
          ContentModel? content}) =>
      BookModel(
        id: id,
        title: title ?? this.title,
        author: author ?? this.author,
        content: content ?? this.content,
        cover: cover ?? this.cover,
        dateNtime: dateNtime ?? this.dateNtime,
        description: description ?? this.description,
        tags: tags ?? this.tags,
      );

  // Database Oprations
  // Extend with Book Handler

  // @ Create Book
  Future<BookModel> createBook() => BookHandler.instance.createBook(this);

  // @ Update Book
  Future<bool> updateBook() => BookHandler.instance.updateBook(this);

  // @ get Book by id
  static Future<BookModel> getBookById({required String id}) =>
      BookHandler.instance.getBook(id);

  // @ Get All Book list
  static Stream<List<BookModel>> getAllBooks() =>
      BookHandler.instance.getBookCollection();

  // @ Delete Book
  Future<bool> deleteBook() =>
      BookHandler.instance.delete(id).then((value) => value);
}
