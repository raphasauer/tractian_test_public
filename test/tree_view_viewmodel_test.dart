import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:tractian_test/models/tree_view_page_state.dart';
import 'package:tractian_test/viewmodels/tree_view_viewmodel.dart';

import 'mocks/mock_repository.dart';

void main() {
  group('TreeViewViewModel', () {
    late TreeViewViewModel viewModel;

    setUp(() {
      viewModel = Get.put(TreeViewViewModel(repository: MockRepository()));
    });

    test('initialize should load previous state if available', () {
      final state = TreeViewPageState(
        unfilteredTree: [],
        filteredTree: [],
        energyOnlyButton: false,
        alertOnlyButton: false,
        filteredText: '',
      );
      viewModel.c.cacheState('unit1', state);

      viewModel.initialize('unit1');
      expect(viewModel.states['unit1'], state);
    });

    test('toggleEnergyButton should update state correctly', () async {
      final state = TreeViewPageState(
        unfilteredTree: [],
        filteredTree: [],
        energyOnlyButton: false,
        alertOnlyButton: false,
        filteredText: '',
      );

      viewModel.initialize('unit1');
      viewModel.c.cacheState('unit1', state);
      viewModel.allLocations['unit1'] =
          await viewModel.futureAssets['unit1'] ?? [];

      viewModel.toggleEnergyButton('unit1');

      expect(viewModel.states['unit1']!.energyOnlyButton, true);
    });

    test('loadAssets should fetch data from repository', () async {
      viewModel.initialize('unit1');
      expect(viewModel.futureAssets['unit1'], isNotNull);
      final locations = await viewModel.futureAssets['unit1'];
      expect(locations, isNotEmpty);
      expect(locations!.length, 2);
    });
  });
}
