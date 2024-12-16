import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

enum SelectedOptionState { bestSeller, recommended}

class HomeController extends GetxController {
  Rx<SelectedOptionState> selectedOptionState = SelectedOptionState.bestSeller.obs;

  void changeSelectedOption(SelectedOptionState newState) {
    selectedOptionState.value = newState;
  }
}
