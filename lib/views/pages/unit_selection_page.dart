import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractian_test/views/widgets/unit_selection_button.dart';
import '../../viewmodels/unit_selection_viewmodel.dart';

class UnitSelectionPage extends StatelessWidget {
  const UnitSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final UnitSelectionViewModel viewModel = Get.put(UnitSelectionViewModel());

    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Image.asset(
            'assets/tractian_logo.png',
            fit: BoxFit.contain,
            height: 25,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Obx(() => ListView.builder(
                  shrinkWrap: true,
                  itemCount: viewModel.units.length,
                  itemBuilder: (context, index) {
                    return UnitSelectionButton(
                      unitName: viewModel.units[index].name,
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }
}
