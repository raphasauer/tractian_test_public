import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/asset.dart';
import '../../models/base.dart';
import '../../models/location.dart';
import '../../viewmodels/tree_tile_view_model.dart';


class TreeTile extends StatelessWidget {
  final Base element;
  final int indentLevel;

  const TreeTile({super.key, required this.element, this.indentLevel = 0});

  @override
  Widget build(BuildContext context) {
    // Create a unique instance of TreeTileViewModel for each TreeTile
    // This way we can hold the value of each tile even if the user
    // exits the screen
    final TreeTileViewModel viewModel = Get.put(TreeTileViewModel(), tag: element.id);

    Widget content;
    if (element is Asset) {
      final asset = element as Asset;
      content = Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(asset.children.isEmpty
                ? 'assets/component.png'
                : 'assets/asset.png'),
          ),
          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    element.name,
                    style: const TextStyle(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (asset.sensorType == 'energy')
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Icon(
                      Icons.flash_on_sharp,
                      size: 15,
                      color: Colors.yellow,
                    ),
                  ),
                if (asset.status == 'alert')
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Icon(
                      Icons.adjust,
                      size: 15,
                      color: Colors.red,
                    ),
                  ),
              ],
            ),
          ),
        ],
      );
    } else if (element is Location) {
      content = Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/location.png'),
          ),
          Expanded(
            child: Text(
              element.name,
              style: const TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );
    } else {
      content = Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          element.name,
          style: const TextStyle(fontSize: 16),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(left: indentLevel * 4.0),
      child: element.children.isEmpty
          ? Container(
              padding: const EdgeInsets.fromLTRB(24, 8, 8, 8),
              child: content,
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: viewModel.toggleExpanded,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 15,
                          child: Obx(() => Icon(
                                viewModel.isExpanded.value
                                    ? Icons.expand_less
                                    : Icons.expand_more,
                              )),
                        ),
                        Expanded(child: content),
                      ],
                    ),
                  ),
                  Obx(() => viewModel.isExpanded.value
                      ? Column(
                          children: element.children
                              .map((child) => TreeTile(
                                    element: child,
                                    indentLevel: indentLevel + 1,
                                  ))
                              .toList(),
                        )
                      : Container()),
                ],
              ),
            ),
    );
  }
}
