import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app_theme.dart';
import '../../../../controllers/address_controller.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  AddressController addressController = Get.put(AddressController());

  final addressFieldController = TextEditingController();
  final streetController = TextEditingController();
  final apartmentController = TextEditingController();
  final postalCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Address'),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Address TextField
              _buildTextField(
                controller: addressFieldController,
                label: 'Address',
                hint: 'Enter your address',
              ),
              const SizedBox(height: 16),

              // Street TextField
              _buildTextField(
                controller: streetController,
                label: 'Street',
                hint: 'Enter street name',
              ),
              const SizedBox(height: 16),

              // Apartment TextField
              _buildTextField(
                controller: apartmentController,
                label: 'Apartment',
                hint: 'Enter apartment number or name',
              ),
              const SizedBox(height: 16),

              // Postal Code TextField
              _buildTextField(
                controller: postalCodeController,
                label: 'Postal Code',
                hint: 'Enter postal code',
              ),
              const SizedBox(height: 16),

              //Label
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      addressController.label.value =
                          "HOME"; // Update the value when tapped
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppTheme.bgGrey,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8),
                        child: Text(
                          "HOME",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      addressController.label.value =
                          "WORK"; // Update the value when tapped
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppTheme.bgGrey,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8),
                        child: Text(
                          "WORK",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      addressController.label.value =
                          "OTHER"; // Update the value when tapped
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppTheme.bgGrey,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8),
                        child: Text(
                          "OTHER",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),

              // Default Address Toggle
              Obx(() => Row(
                    children: [
                      Checkbox(
                        value: addressController.isDefault.value,
                        onChanged: (value) =>
                            addressController.isDefault.value = value ?? false,
                      ),
                      Text(
                        'Set as Default',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  )),
              const SizedBox(height: 16),

              // Update Button
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.00),
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      // Call the updateAddress function from the controller
                      addressController.createAddress(
                        addressFieldController,
                        streetController,
                        apartmentController,
                        postalCodeController,
                        addressController.label.value,
                        addressController.isDefault.value,
                      );
                      Get.back(); // Go back after updating
                    },
                    child: const Text('Add'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppTheme.bgGrey, // Set your desired background color
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none, // No visible border
            ),
          ),
        ),
      ],
    );
  }
}
