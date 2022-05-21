import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:librex/models/author_model.dart';
import 'package:librex/models/book_model.dart';
import 'package:librex/screens/content_screen.dart';

class BookListTile extends StatelessWidget {
  final BookModel book;
  const BookListTile({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => ContentScreen(book: book, route: "tile"));
      },
      child: SizedBox(
        height: 100,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 4, left: 4),
              child: AspectRatio(
                aspectRatio: 16 / 12,
                child: ClipRRect(
                    child: CachedNetworkImage(
                      imageUrl: book.cover,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      book.title,
                      maxLines: 1,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    FutureBuilder<AuthorModel>(
                        future: AuthorModel.getAuthorById(id: book.author),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              "By ${snapshot.data!.dname}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 14),
                            );
                          } else {
                            return const SizedBox();
                          }
                        }),
                    Expanded(
                      child: Text(
                        book.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
