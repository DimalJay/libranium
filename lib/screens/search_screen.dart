import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:librex/controllers/history_controller.dart';
import 'package:librex/controllers/search_controller.dart';
import 'package:librex/widgets/components/book_list_tile.dart';
import 'package:librex/widgets/search_feild.dart';

class SearchScreen extends StatefulWidget {
  final TextEditingController? controller;
  const SearchScreen({Key? key, this.controller}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _searchEditingController;
  late SearchController _searchQueryController;
  late HistoryController _historyController;
  bool historyMode = false;

  @override
  void initState() {
    setState(() {
      _searchEditingController = TextEditingController();
      _searchQueryController = Get.put(SearchController());
      _historyController = Get.put(HistoryController());
      onSearch(widget.controller?.text ?? "");
    });

    super.initState();
  }

  @override
  void dispose() {
    _searchEditingController.dispose();
    super.dispose();
  }

  void onSearch(String query) {
    String _query = query.trim();
    setState(() {
      if (_query.trim().isNotEmpty) {
        _searchEditingController.text = _query;

        _historyController.add(_query);
      }
    });
    if (_query.isEmpty || _query.toString().trim() == "") {
      _searchQueryController.bookList.clear();
      historyMode = true;
    } else {
      historyMode = false;
      _searchQueryController.search(_query);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<SearchController>(builder: (controller) {
        return CustomScrollView(slivers: [
          _headerSection(),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.grey.withOpacity(0.5),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                historyMode
                    ? "Your Recent Seraches Here"
                    : controller.bookList.isEmpty
                        ? "No Results"
                        : "Searching : ${_searchEditingController.text.trim()}",
                style: const TextStyle(
                    color: Colors.black87,
                    fontStyle: FontStyle.italic,
                    fontSize: 16),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(4),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                  ((context, index) =>
                      BookListTile(book: controller.bookList[index])),
                  childCount: controller.bookList.length),
            ),
          ),
          historyMode ? _history() : const SliverToBoxAdapter()
        ]);
      }),
    );
  }

  SliverList _history() {
    List<String> _historyList =
        _historyController.historyList.reversed.toSet().toList();
    return SliverList(
        delegate: SliverChildBuilderDelegate(((context, index) {
      String _historyItem = _historyList[index].trim();
      return ListTile(
        onTap: () => onSearch(_historyItem),
        leading: const Icon(Icons.history),
        title: Text(_historyItem),
      );
    }), childCount: _historyList.length));
  }

  SliverAppBar _headerSection() {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      flexibleSpace: AlphaSearchFeild(
          hasBackButton: true,
          controller: _searchEditingController,
          onSearch: onSearch),
      toolbarHeight: const Size.fromHeight(65).height,
      leading: const SizedBox(),
    );
  }
}
