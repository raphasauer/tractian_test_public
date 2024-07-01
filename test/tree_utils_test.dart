import 'package:flutter_test/flutter_test.dart';
import 'package:tractian_test/models/asset.dart';
import 'package:tractian_test/models/location.dart';
import 'package:tractian_test/utils/tree_utils.dart';

void main() {
  group('Tree Utils', () {
    test('buildTreeFromList should correctly create tree structure', () {
      final node1 = Location(id: '1', name: 'Location 1');
      final node2 = Asset(
          id: '2',
          name: 'Asset 2',
          locationId: '1',
          parentId: null,
          sensorType: 'energy',
          status: 'operational');
      final nodes = [node1, node2];

      final tree = buildTreeFromList(nodes);
      expect(tree['1'], node1);
      expect(tree['1']!.children.contains(node2), true);
    });

    test('calculateTreeHeight should return correct height', () {
      final node1 = Location(id: '1', name: 'Location 1');
      final node2 = Asset(
          id: '2',
          name: 'Asset 2',
          locationId: '1',
          parentId: null,
          sensorType: 'energy',
          status: 'operational');
      final nodes = [node1, node2];
      final tree = buildTreeFromList(nodes);

      final height = calculateTreeHeight(tree);
      expect(height, 2);
    });

    test('filterTree should correctly filter nodes', () {
      final node1 = Location(id: '1', name: 'Location 1');
      final node2 = Asset(
          id: '2',
          name: 'Asset 2',
          locationId: '1',
          parentId: null,
          sensorType: 'energy',
          status: 'operational');
      final node3 = Asset(id: '3', name: 'Asset 3', locationId: '1', status: 'alert', parentId: null, sensorType: 'vibration');

      final nodes = [node1, node2, node3];

      final filteredNodes = filterTree(nodes, 'Asset', false, false);
      expect(filteredNodes.length, 2);
    });
  });
}
