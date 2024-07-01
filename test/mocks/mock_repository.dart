import 'package:tractian_test/models/asset.dart';
import 'package:tractian_test/models/base.dart';
import 'package:tractian_test/models/location.dart';
import 'package:tractian_test/viewmodels/repository/base_repository.dart';

class MockRepository implements BaseRepository {
  @override
  Future<List<Base>> loadAssets(String unit) async {
    return [
      Location(id: '1', name: 'Local 1'),
      Asset(
          id: '2',
          name: 'Asset 1',
          locationId: '1',
          parentId: null,
          sensorType: 'energy',
          status: 'alert'),
    ];
  }

  @override
  List<Base> parseLocations(List<dynamic> json) {
    return [
      Location(id: '1', name: 'Local 1'),
    ];
  }

  @override
  List<Base> parseAssets(List<dynamic> json) {
    return [
      Asset(
          id: '2',
          name: 'Asset 1',
          locationId: '1',
          parentId: null,
          sensorType: 'energy',
          status: 'alert'),
    ];
  }
}
