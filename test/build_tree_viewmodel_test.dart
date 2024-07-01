import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:tractian_test/models/location.dart';
import 'package:tractian_test/viewmodels/build_tree_viewmodel.dart';

void main() {
  group('BuildTreeViewModel', () {
    late BuildTreeViewModel viewModel;

    setUp(() {
      viewModel = Get.put(BuildTreeViewModel());
    });

    test('buildTree should correctly create tree structure', () {
      final node1 = Location(id: '1', name: 'Node 1');
      final node2 = Location(id: '2', name: 'Node 2', parentId: '1');
      final nodes = [node1, node2];

      viewModel.buildTree(nodes);

      expect(viewModel.locationTree['1'], node1);
      expect(viewModel.locationTree['2'], null);
      expect(viewModel.locationTree['1']!.children.contains(node2), true);
    });
  });
}
