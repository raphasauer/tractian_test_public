import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:tractian_test/viewmodels/tree_tile_view_model.dart';

void main() {
  group('TreeTileViewModel', () {
    late TreeTileViewModel viewModel;

    setUp(() {
      viewModel = Get.put(TreeTileViewModel());
    });

    test('toggleExpanded should update isExpanded correctly', () {
      expect(viewModel.isExpanded.value, false);

      viewModel.toggleExpanded();
      expect(viewModel.isExpanded.value, true);

      viewModel.toggleExpanded();
      expect(viewModel.isExpanded.value, false);
    });
  });
}
