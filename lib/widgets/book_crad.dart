import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:librex/models/book_model.dart';
import 'package:librex/services/inline_services.dart';

import '../models/author_model.dart';
import '../screens/content_screen.dart';

class AlphaBookCard extends StatelessWidget {
  final BookModel book;
  const AlphaBookCard({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _cradHeader(author: book.author, timeNdate: book.dateNtime),
              _cradTitle(title: book.title),
              _cradBody(context,
                  cover: book.cover, description: book.description),
            ],
          ),
        ),
        _cradSpacer()
      ],
    );
  }

  Widget _cradSpacer() {
    return Container(
      color: Colors.black.withOpacity(0.2),
      height: 6,
      margin: const EdgeInsets.only(top: 8),
    );
  }

  Padding _cradTitle({required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _cradHeader({required String author, required DateTime timeNdate}) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: FutureBuilder<AuthorModel>(
              future: AuthorModel.getAuthorById(id: book.author),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return CachedNetworkImage(
                    imageUrl: snapshot.data!.profilePIC,
                    fit: BoxFit.cover,
                  );
                } else {
                  return const SizedBox();
                }
              }),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<AuthorModel>(
                future: AuthorModel.getAuthorById(id: book.author),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      snapshot.data!.dname,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    );
                  } else {
                    return const SizedBox();
                  }
                }),
            Text(dateToString(book.dateNtime))
          ],
        )
      ],
    );
  }

  Container _cradBody(BuildContext context,
      {required String description, required String cover}) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: AspectRatio(
        aspectRatio: 7 / 8,
        child: Stack(
          fit: StackFit.loose,
          children: [
            _cardBodyCover(cover),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                decoration:
                    BoxDecoration(color: Colors.black.withOpacity(0.65)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            book.title,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 5),
                          _cardBodyDescription(description),
                        ],
                      ),
                      const SizedBox(height: 8),
                      _cardBodyButton(context),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Text _cardBodyDescription(String description) {
    return Text(
      shrinkText(description),
      maxLines: 4,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(color: Colors.white, fontSize: 16),
    );
  }

  RawMaterialButton _cardBodyButton(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        // showModalBottomSheet(
        //     isScrollControlled: true,
        //     context: context,
        //     builder: (context) {
        //       return BookModelBottomSheet(book: book);
        //     });
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ContentScreen(
            book: book,
            route: "card",
          );
        }));
      },
      child: const Text(
        "Read Continue",
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(width: 1, color: Colors.white)),
    );
  }

  Positioned _cardBodyCover(String cover) {
    return Positioned(
      bottom: 0,
      top: 0,
      right: 0,
      left: 0,
      child: Hero(
          tag: book.cover + "crad",
          child: CachedNetworkImage(imageUrl: cover, fit: BoxFit.cover)),
    );
  }
}
