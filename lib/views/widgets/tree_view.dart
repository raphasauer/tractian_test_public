import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/base.dart';
import '../../viewmodels/build_tree_viewmodel.dart';
import 'tree_tile.dart';

class TreeView extends StatelessWidget {
  final List<Base> locations;

  const TreeView({super.key, required this.locations});

  @override
  Widget build(BuildContext context) {
    final BuildTreeViewModel viewModel = Get.put(BuildTreeViewModel());
    viewModel.buildTree(locations);

    return ListView.builder(
      itemCount: viewModel.rootLocations.length,
      itemBuilder: (context, index) {
        return TreeTile(element: viewModel.rootLocations[index]);
      },
    );
  }
}
