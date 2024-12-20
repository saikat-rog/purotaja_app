import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app_theme.dart';
import '../../../../controllers/address_controller.dart';

class EditAddressScreen extends StatefulWidget {
  final String addressId;

  const EditAddressScreen({super.key, required this.addressId});

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  AddressController addressController = Get.put(AddressController());

  final addressFieldController = TextEditingController();
  final streetController = TextEditingController();
  final apartmentController = TextEditingController();
  final postalCodeController = TextEditingController();

  // Track selected label
  String selectedLabel = 'HOME';

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
          //Text fields
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

              // Label
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildLabelButton('HOME'),
                  _buildLabelButton('WORK'),
                  _buildLabelButton('OTHER'),
                ],
              ),
              SizedBox(height: 20),

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
                      addressController.updateAddress(
                        widget.addressId,
                        addressFieldController,
                        streetController,
                        apartmentController,
                        postalCodeController,
                        selectedLabel,
                        addressController.isDefault.value,
                      );
                      Get.back(); // Go back after updating
                    },
                    child: const Text('Update Address'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Label Button Widget with dynamic background color
  Widget _buildLabelButton(String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLabel = label; // Update selected label
          addressController.label.value = label; // Update controller label
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: selectedLabel == label
              ? AppTheme.lightTheme.primaryColor // Set background to primary color when selected
              : AppTheme.bgGrey, // Default background color
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Text(
            label,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: selectedLabel == label
                  ? Colors.white // Text color when selected
                  : Colors.black, // Default text color
            ),
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