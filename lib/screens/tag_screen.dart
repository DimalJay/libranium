import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:librex/controllers/tag_controller.dart';
import 'package:librex/services/inline_services.dart';
import 'hashtag_screen.dart';

class TagScreen extends StatelessWidget {
  TagScreen({Key? key}) : super(key: key);
  final TagController tagController = Get.put(TagController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<TagController>(builder: (controller) {
        return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                title: const Text("Popular Tags",
                    style: TextStyle(color: Colors.black)),
                backgroundColor: Colors.transparent,
                iconTheme: Theme.of(context).iconTheme,
                leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    onPressed: () => Navigator.pop(context)),
              ),
              SliverToBoxAdapter(
                child: SingleChildScrollView(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8,
                    children: [
                      ...organizeTags(list: controller.tagList, range: 0)
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
                    ],
                  ),
                ),
              )
            ]);
      }),
    );
  }
}
