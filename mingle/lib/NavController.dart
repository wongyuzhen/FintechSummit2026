import 'package:get/get.dart';

class NavController extends GetxController {
  // Reactive selected index
  var selectedIndex = 0.obs;

  // Optional: update index
  void changeTabIndex(int index) {
        selectedIndex.value = index;  // Normal tab switching
  }
}