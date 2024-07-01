import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:tractian_test/models/base.dart';
import 'package:tractian_test/models/tree_view_page_state.dart';
import 'package:tractian_test/models/asset.dart';
import 'package:tractian_test/models/location.dart';

import '../base_repository.dart';

/// Implementation of BaseRepository that gets data from assets
class LocalDataRepository extends BaseRepository {
  final TreeViewPageState? state;

  LocalDataRepository(this.state);

  @override
  Future<List<Base>> loadAssets(String unit) async {
    if (state != null && state!.unfilteredTree.isNotEmpty) {
      return state!.unfilteredTree;
    } else {
      final String locationString =
          await rootBundle.loadString('assets/$unit/locations.json');
      final List<dynamic> locationJsonData = json.decode(locationString);
      final String assetString =
          await rootBundle.loadString('assets/$unit/assets.json');
      final List<dynamic> assetJsonData = json.decode(assetString);
      var locations = parseLocations(locationJsonData);
      var assets = parseAssets(assetJsonData);
      List<Base> list = [...locations, ...assets];
      return list;
    }
  }

  @override
  List<Base> parseLocations(List<dynamic> json) {
    return json.map((data) => Location.fromJson(data)).toList();
  }

  @override
  List<Base> parseAssets(List<dynamic> json) {
    return json.map((data) => Asset.fromJson(data)).toList();
  }
}
