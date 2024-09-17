
import 'package:hive/hive.dart';

part 'source.g.dart';

@HiveType(typeId: 3)
class Source {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  Source({this.id, this.name});

  Source.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}


