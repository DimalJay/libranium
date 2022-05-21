import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:librex/models/book_model.dart';
import '../models/author_model.dart';
import '../screens/content_screen.dart';

class AlphaBookTile extends StatelessWidget {
  final BookModel book;
  const AlphaBookTile({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          // showModalBottomSheet(
          //     isScrollControlled: true,
          //     context: context,
          //     builder: (context) {
          //       return BookModelBottomSheet(book: book);
          //     });
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ContentScreen(
              book: book,
              route: "tile",
            );
          }));
        },
        child: Container(
          padding: const EdgeInsets.all(16 / 3),
          child: AspectRatio(
            aspectRatio: 9 / 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Hero(
                    tag: book.cover + "tile",
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16 / 2),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            book.cover,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          book.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        FutureBuilder<AuthorModel>(
                            future: AuthorModel.getAuthorById(id: book.author),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text("By ${snapshot.data!.dname}");
                              } else {
                                return const SizedBox();
                              }
                            }),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
