import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:librex/controllers/book_controller.dart';
import 'package:librex/controllers/tag_controller.dart';
import 'package:librex/models/book_model.dart';
import 'package:librex/screens/hashtag_screen.dart';
import 'package:librex/screens/search_screen.dart';
import 'package:librex/screens/tag_screen.dart';
import 'package:librex/services/inline_services.dart';
import 'package:librex/services/network_services.dart';
import 'package:librex/style/constraints.dart';
import 'package:librex/widgets/book_tile.dart';
import 'package:librex/widgets/check_connection.dart';
import 'package:librex/widgets/components/no_internet.dart';
import '../widgets/book_crad.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final BookController bookController = Get.put(BookController());
  final TagController tagController = Get.put(TagController());

  late Future<bool> connectionTrigger;

  Future<void> _onRefresh() async {
    bookController.feedRandomize();
  }

  @override
  void initState() {
    connectionTrigger = NetworkService.instance.checkConnection();
    super.initState();
  }

  void reloadConnectionTrigger() {
    setState(() {
      connectionTrigger = NetworkService.instance.checkConnection();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _headerSection(context),
      body: RefreshIndicator(
        color: baseColor,
        onRefresh: _onRefresh,
        child: CheckConnection(
          trigger: connectionTrigger,
          noInternet: NoInterNetWidget(trigger: reloadConnectionTrigger),
          child: GetX<BookController>(builder: (BookController bookController) {
            return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: _pageBody(context, bookController));
          }),
        ),
      ),
    );
  }

  List<Widget> _pageBody(BuildContext context, BookController controller) {
    return [
      _trendingTagSection(context),
      _latestSection(context, bookList: controller.bookLatestList),
      _feedSection(bookList: controller.bookFeedList),
    ];
  }

  AppBar _headerSection(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: const Text(
        "Libranium",
        style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 141, 0, 66)),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const SearchScreen();
            }));
          },
          icon: const Icon(CupertinoIcons.search),
        ),
        // IconButton(
        //   onPressed: () {},
        //   icon: const Icon(CupertinoIcons.person_alt_circle),
        // ),
      ],
      iconTheme: Theme.of(context).iconTheme,
    );
  }

  SliverList _feedSection({required List<BookModel> bookList}) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
          (context, index) => AlphaBookCard(book: bookList[index]),
          childCount: bookList.length),
    );
  }

  SliverToBoxAdapter _latestSection(BuildContext context,
      {required List<BookModel> bookList}) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _headerTitle(context, text: "Latest Books", onPressed: () {}),
          Container(
              padding: const EdgeInsets.all(8),
              height: 300,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: ((context, index) =>
                    SizedBox(child: AlphaBookTile(book: bookList[index]))),
                itemCount: bookList.length,
              )),
        ],
      ),
    );
  }

  SliverToBoxAdapter _trendingTagSection(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _headerTitle(context, text: "Trending Tags", onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return TagScreen();
            }));
          }),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GetX<TagController>(builder: (controller) {
              return Wrap(
                children: [
                  ...organizeTags(list: controller.tagList, range: 8)
                      .map(
                        (e) => RawChip(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return HashTagScreen(tag: e.toLowerCase());
                            }));
                          },
                          label: Text(e),
                        ),
                      )
                      .toList(),
                  RawChip(
                    label: const Icon(Icons.more_horiz),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return TagScreen();
                      }));
                    },
                  )
                ],
                spacing: 10,
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _headerTitle(BuildContext context,
      {required String text, required Function() onPressed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(text, style: Theme.of(context).textTheme.headline1),
          IconButton(
              icon: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
              onPressed: onPressed),
        ],
      ),
    );
  }
}
