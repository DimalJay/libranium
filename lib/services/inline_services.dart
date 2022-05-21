import 'dart:collection';

const months = [
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "May",
  "Jun",
  "Jul",
  "Aug",
  "Sep",
  "Oct",
  "Nov",
  "Dec"
];

String dateToString(DateTime dateTime) {
  return "${dateTime.day} ${months[dateTime.month - 1]} ${dateTime.year}";
}

String shrinkText(String text) {
  List<String> split = text.split("\n");
  split.removeWhere((element) => element.trim() == "");
  return split.toSet().join('\n\n').trim();
}

List<String> organizeTags({required List<String> list, int range = 5}) {
  List<String> _nList = list.map((element) => element.toUpperCase()).toList();
  var map = {};
  for (var x in _nList) {
    map[x] = !map.containsKey(x) ? (1) : (map[x] + 1);
  }
  var sortedKeys = map.keys.toList(growable: false)
    ..sort((k1, k2) => map[k1].compareTo(map[k2]));
  LinkedHashMap sortedMap = LinkedHashMap.fromIterable(sortedKeys,
      key: (k) => k, value: (k) => map[k]);
  List<String> _fList =
      LinkedHashMap.fromEntries(sortedMap.entries.toList().reversed)
          .entries
          .map<String>((e) => e.key.toString())
          .toList();
  return _fList.length > range
      ? range != 0
          ? _fList.getRange(0, range).toList()
          : _fList
      : _fList;
}
