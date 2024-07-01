import 'package:get/get.dart';
import '../models/unit.dart';

/// View model of the unit selection page
class UnitSelectionViewModel extends GetxController {
  var units = <Unit>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUnits();
  }

  /// Loads test units into memory
  void fetchUnits() {
    var unitList = [
      Unit(name: 'Jaguar'),
      Unit(name: 'Tobias'),
      Unit(name: 'Apex'),
    ];
    units.assignAll(unitList);
  }
}
