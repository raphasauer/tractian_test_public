import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/base.dart';
import '../../viewmodels/tree_view_viewmodel.dart';
import '../widgets/tree_view.dart';

class TreeViewPage extends StatelessWidget {
  const TreeViewPage({super.key, required this.unit});

  final String unit;

  @override
  Widget build(BuildContext context) {
    final TreeViewViewModel viewModel = Get.put(TreeViewViewModel());
    viewModel.initialize(unit);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('Assets')),
      body: Obx(
        () => FutureBuilder<List<Base>>(
          future: viewModel.futureAssets[unit],
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No data found.'));
            } else {
              if (viewModel.allLocations[unit]?.isEmpty ?? true) {
                viewModel.allLocations[unit] = snapshot.data!;
                if (viewModel.states[unit]?.filteredTree.isEmpty ?? true) {
                  viewModel.states[unit]?.filteredTree =
                      viewModel.allLocations[unit]!;
                }
              }

              //Logic to dynamically size the screen based on tree depth
              var height =
                  viewModel.calculateTreeSize(viewModel.allLocations[unit]!);
              var screenSize = MediaQuery.of(context).size.width +
                  ((height - 5).abs() / 3) * MediaQuery.of(context).size.width;

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFF3F6),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextField(
                            controller: viewModel.searchControllers[unit],
                            onChanged: (value) => viewModel.updateFilter(unit),
                            decoration: const InputDecoration(
                              fillColor: Colors.transparent,
                              filled: true,
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 15.0,
                                horizontal: 10.0,
                              ),
                            ),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Obx(() => viewModel.isSearchEmpty[unit]?.value ?? true
                            ? const Positioned(
                                left: 48,
                                child: Text(
                                  'Buscar Ativo ou Local',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              )
                            : Container()),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Obx(
                        () => ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                viewModel.states[unit]?.energyOnlyButton ??
                                        false
                                    ? Colors.blue
                                    : Colors.grey,
                          ),
                          onPressed: () => viewModel.toggleEnergyButton(unit),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.flash_on,
                                  size: 15,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Sensor de energia'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Obx(
                        () => ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                viewModel.states[unit]?.alertOnlyButton ?? false
                                    ? Colors.blue
                                    : Colors.grey,
                          ),
                          onPressed: () => viewModel.toggleAlertButton(unit),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.error_outline,
                                  size: 15,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Crítico'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Obx(
                    () => SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.73,
                          width: screenSize,
                          child: TreeView(
                              locations:
                                  viewModel.states[unit]?.filteredTree ?? []),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
