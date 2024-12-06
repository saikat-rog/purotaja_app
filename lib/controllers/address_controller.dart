import 'package:get/get.dart';

class AddressController extends GetxController {
  var addresses = <String>[].obs;
  final int maxAddresses = 10;

  void addAddress(String address) {
    if (addresses.length < maxAddresses) {
      addresses.add(address);
    } else {
      Get.snackbar("Limit Reached", "You can only add up to $maxAddresses addresses.");
    }
  }

  void removeAddress(int index) {
    addresses.removeAt(index);
  }
}
