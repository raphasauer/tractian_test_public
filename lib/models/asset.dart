import 'package:tractian_test/models/base.dart';

class Asset extends Base {
  final String? locationId;
  final String? sensorType;
  final String? status;

  Asset({
    required String id,
    required String name,
    required this.locationId,
    required String? parentId,
    required this.sensorType,
    required this.status,
  }) : super(name: name, children: [], id: id, parentId: parentId);

  factory Asset.fromJson(dynamic data) {
    var id = data['id'];
    var name = data['name'];
    var locationId = data['locationId'];
    var parentId = data['parentId'];
    var sensorType = data['sensorType'];
    var status = data['status'];

    return Asset(
      id: id,
      name: name,
      locationId: locationId,
      parentId: parentId,
      sensorType: sensorType,
      status: status,
    );
  }
}
