import 'package:get/get.dart';
import '../models/asset.dart';
import '../models/base.dart';
import '../models/location.dart';

class BuildTreeViewModel extends GetxController {
  late Map<String, Base> locationTree;
  late List<Base> rootLocations;

  /// Builds a tree view from [repositories] with the following topology:
  /// Root nodes (with no parents or locationId) are 
  /// accessible by their keys, the other nodes are only
  /// accessed by iterating from root by their children
  void buildTree(List<Base> repositories) {
    locationTree = _buildTreeView(repositories);
    rootLocations = locationTree.values.toList();
  }

  Map<String, Base> _buildTreeView(List<Base> repositories) {
    Map<String, Base> repositoryMap = {for (var loc in repositories) loc.id: loc};

    for (var loc in repositories) {
      if (loc.parentId != null) {
        var parent = repositoryMap[loc.parentId];
        if (parent != null &&
            !parent.children.any((child) => child.id == loc.id)) {
          parent.children.add(loc);
        }
      } else if (loc is Asset && loc.locationId != null) {
        var parent = repositoryMap[loc.locationId];
        if (parent != null &&
            !parent.children.any((child) => child.id == loc.id)) {
          parent.children.add(loc);
        }
      }
    }

    var returnMap = {
      for (var loc in repositoryMap.values)
        if (loc is Location && loc.parentId == null)
          loc.id: loc
        else if (loc is Asset && loc.locationId == null && loc.parentId == null)
          loc.id: loc
    };
    return returnMap;
  }
}
