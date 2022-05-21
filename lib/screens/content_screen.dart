import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:librex/models/book_model.dart';
import 'package:librex/models/content_model.dart';
import 'package:librex/models/author_model.dart';
import 'package:librex/screens/hashtag_screen.dart';
import 'package:librex/services/inline_services.dart';
import '../handlers/content_handler.dart';

class ContentScreen extends StatelessWidget {
  final BookModel book;
  final String route;
  const ContentScreen({Key? key, required this.book, required this.route})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            title: Text(
              book.title,
              style: const TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.transparent,
            iconTheme: Theme.of(context).iconTheme,
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(CupertinoIcons.back)),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: AspectRatio(
                  aspectRatio: 16 / 13,
                  child: Hero(
                    tag: book.cover + route,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16 / 1.5),
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(book.cover),
                            fit: BoxFit.cover),
                      ),
                    ),
                  )),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 16, bottom: 8),
              child: Column(
                children: [
                  Text(
                    book.title,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 4),
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
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                shrinkText(book.description),
                style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                    fontSize: 16),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 1,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              color: Colors.black12,
            ),
          ),
          SliverToBoxAdapter(
            child: FutureBuilder<ContentModel>(
                future: ContentHanlder.instance.getContent(book.content.id!),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    ContentModel contentModel = snapshot.data!;
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Text(
                        shrinkText(contentModel.content),
                        textAlign: TextAlign.justify,
                        softWrap: true,
                        textScaleFactor: MediaQuery.textScaleFactorOf(context),
                        style: const TextStyle(fontSize: 18),
                      ),
                    );
                  } else {
                    return Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(16 * 2),
                        child: const CircularProgressIndicator());
                  }
                }),
          ),
          SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Wrap(spacing: 8, children: [
              ...book.tags.map((e) => RawChip(
                  onPressed: () {
                    Get.to(() => HashTagScreen(tag: e.toString()));
                  },
                  label: Text(e.toString())))
            ]),
          ))
        ],
      ),
    );
  }
}
