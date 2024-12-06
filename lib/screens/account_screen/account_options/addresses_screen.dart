import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/address_controller.dart';

class AddressScreen extends StatelessWidget {
  final AddressController addressController = Get.put(AddressController());

  AddressScreen({Key? key}) : super(key: key);

  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Addresses"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _addressController,
                    decoration: const InputDecoration(
                      hintText: "Enter Address",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    if (_addressController.text.isNotEmpty) {
                      addressController.addAddress(_addressController.text);
                      _addressController.clear();
                    } else {
                      Get.snackbar("Error", "Address field cannot be empty.");
                    }
                  },
                  child: const Text("Add"),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: addressController.addresses.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(addressController.addresses[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => addressController.removeAddress(index),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
