import 'package:get/state_manager.dart';
import '../models/tree_view_page_state.dart';

/// Class that holds the state controller for each unit
class TreeStatesController extends GetxController {
  var state = <String, TreeViewPageState>{}.obs;

  /// Saves [newState] for a given [unit]
  void cacheState(String unit, TreeViewPageState newState) {
    state[unit] = newState;
  }
}
