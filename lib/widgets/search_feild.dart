import 'package:flutter/material.dart';
import 'package:librex/screens/search_screen.dart';
import 'package:librex/style/constraints.dart';

class AlphaSearchFeild extends StatefulWidget {
  final TextEditingController controller;
  final bool hasBackButton;
  final bool home;
  final Function(String value) onSearch;

  const AlphaSearchFeild({
    Key? key,
    this.hasBackButton = false,
    this.home = false,
    required this.controller,
    required this.onSearch,
  }) : super(key: key);

  @override
  State<AlphaSearchFeild> createState() => _AlphaSearchFeildState();
}

class _AlphaSearchFeildState extends State<AlphaSearchFeild> {
  void onChaned(String value) {
    //widget.controller.text = value;
  }
  void onSearchButtonClicked() {
    if (widget.home) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return SearchScreen(controller: widget.controller);
      }));
    } else {
      widget.onSearch(widget.controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(right: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.hasBackButton
              ? IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  onPressed: () => Navigator.pop(context))
              : const SizedBox(width: 16),
          Expanded(
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextFormField(
                textAlignVertical: TextAlignVertical.center,
                cursorColor: Colors.black87,
                cursorWidth: 1,
                onFieldSubmitted: widget.onSearch,
                onChanged: onChaned,
                controller: widget.controller,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.08),
                    border: InputBorder.none,
                    hintText: "Search",
                    hintStyle: const TextStyle(fontSize: 18),
                    suffixIcon: GestureDetector(
                      onTap: onSearchButtonClicked,
                      child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: baseColor),
                          child: const Icon(Icons.search, color: Colors.white)),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16)),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
