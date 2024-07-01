import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/tree_view_page_state.dart';
import '../models/base.dart';
import '../utils/tree_utils.dart';
import 'repository/base_repository.dart';
import 'repository/local/repository.dart';
import 'tree_state_controller.dart';

class TreeViewViewModel extends GetxController {
  /// This variable controlls the cached states for each tree view page
  final TreeStatesController c = Get.put(TreeStatesController());
  late BaseRepository repository;

  var states = <String, TreeViewPageState>{}.obs;
  var searchControllers = <String, TextEditingController>{};
  var isSearchEmpty = <String, RxBool>{};

  var futureAssets = <String, Future<List<Base>>>{}.obs;
  var allLocations = <String, List<Base>>{}.obs;

  TreeViewViewModel({BaseRepository? repository}) {
    this.repository = repository ?? LocalDataRepository(null);
  }

  /// Loads the previous [unit] state, add the unfiltered assets
  /// and add listener for showing the empty text in the textfield
  void initialize(String unit) {
    loadPreviousState(unit);
    futureAssets[unit] = repository.loadAssets(unit);
    searchControllers[unit]?.addListener(() {
      isSearchEmpty[unit]?.value =
          searchControllers[unit]?.text.isEmpty ?? true;
    });
  }

  /// If [unit] has a previous state saved on the global controller,
  /// loads it. If not create an empty state, fill it with the default
  /// elements and caches it
  void loadPreviousState(String unit) {
    if (c.state[unit] != null) {
      states[unit] = c.state[unit]!;
      searchControllers[unit] =
          TextEditingController(text: states[unit]?.filteredText);
      isSearchEmpty[unit] =
          RxBool(searchControllers[unit]?.text.isEmpty ?? true);
    } else {
      states[unit] = TreeViewPageState(
        unfilteredTree: [],
        filteredTree: [],
        energyOnlyButton: false,
        alertOnlyButton: false,
        filteredText: '',
      );
      searchControllers[unit] = TextEditingController();
      isSearchEmpty[unit] = RxBool(true);
      c.cacheState(unit, states[unit]!); // Cache the state on the first access
    }
  }

  /// Updates the [filteredTree] parameter from [TreeViewState]
  /// with the filtered input from [filteredText], [energyOnlyButton]
  /// and [alertOnlyButton]
  void updateFilter(String unit) {
    states[unit] = states[unit]!.copyWith(
      filteredText: searchControllers[unit]?.text ?? '',
      filteredTree: filterTree(
        allLocations[unit]!,
        searchControllers[unit]?.text ?? '',
        states[unit]!.energyOnlyButton,
        states[unit]!.alertOnlyButton,
      ),
    );
    c.cacheState(unit, states[unit]!);
  }

  void toggleEnergyButton(String unit) {
    states[unit] = states[unit]!.copyWith(
      energyOnlyButton: !states[unit]!.energyOnlyButton,
      filteredTree: filterTree(
        allLocations[unit]!,
        searchControllers[unit]?.text ?? '',
        !states[unit]!.energyOnlyButton,
        states[unit]!.alertOnlyButton,
      ),
    );
    c.cacheState(unit, states[unit]!);
  }

  void toggleAlertButton(String unit) {
    states[unit] = states[unit]!.copyWith(
      alertOnlyButton: !states[unit]!.alertOnlyButton,
      filteredTree: filterTree(
        allLocations[unit]!,
        searchControllers[unit]?.text ?? '',
        states[unit]!.energyOnlyButton,
        !states[unit]!.alertOnlyButton,
      ),
    );
    c.cacheState(unit, states[unit]!);
  }

  /// Finds the tree level in order to calculate the adequate size of the
  /// screen
  int calculateTreeSize(List<Base> locations) {
    return calculateTreeHeight(buildTreeFromList(locations));
  }

  @override
  void onClose() {
    for (var controller in searchControllers.values) {
      controller.dispose();
    }
    super.onClose();
  }
}
