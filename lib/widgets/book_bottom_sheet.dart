import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:librex/models/book_model.dart';
import 'package:librex/services/inline_services.dart';

import '../screens/content_screen.dart';

class BookModelBottomSheet extends StatelessWidget {
  final BookModel book;
  const BookModelBottomSheet({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: CachedNetworkImageProvider(book.cover),
              fit: BoxFit.cover)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.2)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    Text(
                      book.title,
                      style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "By ${book.author}",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: AspectRatio(
                      aspectRatio: 10 / 16,
                      child: CachedNetworkImage(
                        imageUrl: book.cover,
                        fit: BoxFit.cover,
                      )),
                ),
                const SizedBox(height: 16),
                Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _bottomSheetRowItem(
                        icon: Icons.star,
                        text: "4.5",
                      ),
                      _bottomSheetRowItem(
                        icon: Icons.favorite,
                        text: "100",
                      ),
                      _bottomSheetRowItem(
                        icon: Icons.remove_red_eye_outlined,
                        text: "1.4K",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  shrinkText(book.description),
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  icon: const Icon(CupertinoIcons.book),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    elevation: 1,
                    padding: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ContentScreen(
                        book: book,
                        route: "null",
                      );
                    }));
                  },
                  label: const Text(
                    "Start Reading",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded _bottomSheetRowItem({required IconData icon, required String text}) {
    return Expanded(
        child: Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
        ),
        Text(
          text,
          style: const TextStyle(color: Colors.white),
        )
      ],
    ));
  }
}
