import 'package:tractian_test/models/base.dart';

class Location extends Base {
  Location({
    required String id,
    required String name,
    String? parentId,
  }) : super(name: name, children: [], id: id, parentId: parentId);

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      name: json['name'],
      parentId: json['parentId'],
    );
  }
}
