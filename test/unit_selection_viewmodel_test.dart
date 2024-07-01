import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:tractian_test/viewmodels/unit_selection_viewmodel.dart';

void main() {
  group('UnitSelectionViewModel', () {
    late UnitSelectionViewModel viewModel;

    setUp(() {
      viewModel = Get.put(UnitSelectionViewModel());
    });

    test('fetchUnits should populate units list', () {
      expect(viewModel.units.isEmpty, false);
      expect(viewModel.units.length, 3);
    });
  });
}
