import 'package:flutter/material.dart';

import '../pages/tree_view_page.dart';

class UnitSelectionButton extends StatelessWidget {
  const UnitSelectionButton({
    Key? key,
    required this.unitName,
  }) : super(key: key);

  final String unitName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      height: 80,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TreeViewPage(unit: unitName.toLowerCase()),
            ),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.warehouse_outlined,
                size: 30,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '$unitName unit',
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
