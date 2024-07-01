// ignore_for_file: unnecessary_getters_setters

import 'base.dart';

class TreeViewPageState {
  List<Base> _unfilteredTree;
  List<Base> _filteredTree;
  bool _energyOnlyButton;
  bool _alertOnlyButton;
  String _filteredText;

  TreeViewPageState({
    required List<Base> unfilteredTree,
    required List<Base> filteredTree,
    required bool energyOnlyButton,
    required bool alertOnlyButton,
    required String filteredText,
  })  : _unfilteredTree = unfilteredTree,
        _filteredTree = filteredTree,
        _energyOnlyButton = energyOnlyButton,
        _alertOnlyButton = alertOnlyButton,
        _filteredText = filteredText;

  // Getters
  List<Base> get unfilteredTree => _unfilteredTree;
  List<Base> get filteredTree => _filteredTree;
  bool get energyOnlyButton => _energyOnlyButton;
  bool get alertOnlyButton => _alertOnlyButton;
  String get filteredText => _filteredText;

  // Setters
  set unfilteredTree(List<Base> value) {
    _unfilteredTree = value;
  }

  set filteredTree(List<Base> value) {
    _filteredTree = value;
  }

  set energyOnlyButton(bool value) {
    _energyOnlyButton = value;
  }

  set alertOnlyButton(bool value) {
    _alertOnlyButton = value;
  }

  set filteredText(String value) {
    _filteredText = value;
  }

  TreeViewPageState copyWith({
    List<Base>? unfilteredTree,
    List<Base>? filteredTree,
    bool? energyOnlyButton,
    bool? alertOnlyButton,
    String? filteredText,
  }) {
    return TreeViewPageState(
      unfilteredTree: unfilteredTree ?? _unfilteredTree,
      filteredTree: filteredTree ?? _filteredTree,
      energyOnlyButton: energyOnlyButton ?? _energyOnlyButton,
      alertOnlyButton: alertOnlyButton ?? _alertOnlyButton,
      filteredText: filteredText ?? _filteredText,
    );
  }
}
