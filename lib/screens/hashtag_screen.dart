import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:librex/controllers/search_controller.dart';
import 'package:librex/widgets/components/book_list_tile.dart';

class HashTagScreen extends StatefulWidget {
  final String tag;
  const HashTagScreen({Key? key, required this.tag}) : super(key: key);

  @override
  State<HashTagScreen> createState() => _HashTagScreenState();
}

class _HashTagScreenState extends State<HashTagScreen> {
  late SearchController _searchController;
  @override
  void initState() {
    _searchController = Get.put(SearchController());
    setState(() {
      _searchController.searchByTag(widget.tag.toLowerCase());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetX<SearchController>(builder: (controller) {
      return CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text(
              "Trending Hashtags",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.transparent,
            iconTheme: Theme.of(context).iconTheme,
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(CupertinoIcons.back)),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  const Icon(Icons.tag, size: 32),
                  const SizedBox(width: 8),
                  Text(
                    widget.tag.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: Container(
                  margin: const EdgeInsets.all(12),
                  color: Colors.black12,
                  height: 1)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) =>
                      BookListTile(book: controller.tagBookList[index]),
                  childCount: controller.tagBookList.length),
            ),
          )
        ],
      );
    }));
  }
}
