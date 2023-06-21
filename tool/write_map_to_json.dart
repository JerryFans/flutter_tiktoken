import 'dart:convert';
import 'dart:io';
import 'token_map/index.dart';

void main() async {
  var map = {
    'cl100k_base': cl100kBase,
    'gpt2': gpt2,
    'p50k_base': p50kBase,
    'r50k_base': r50kBase,
  };

  for (var key in map.keys) {

    var i = 1;
    var temp = <String, int>{};
    var data = map[key];
    if (data == null) {
      continue;
    }
    var dir = Directory(key);
    if (dir.existsSync()) {
      dir.deleteSync(recursive: true);
    }
    dir.createSync();
    
    for (var entry in data.entries) {
      temp[entry.key] = entry.value;
      if (temp.length == 10000) {
        await File('$key/${key}_$i.json').writeAsString(json.encode(temp));
        temp = <String, int>{};
        i++;
      }
    }
    if (temp.isNotEmpty) {
      await File('$key/${key}_$i.json').writeAsString(json.encode(temp));
    }
  }
}
