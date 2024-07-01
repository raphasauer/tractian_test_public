import 'package:get/get.dart';

class TreeTileViewModel extends GetxController {
  final RxBool isExpanded = false.obs;

  void toggleExpanded() {
    isExpanded.value = !isExpanded.value;
  }
}
