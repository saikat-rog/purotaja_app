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

  // Track the selected label as a state variable
  String selectedLabel = 'HOME';

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Address', style: Theme.of(context).textTheme.headlineMedium),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Address TextField
              _buildTextField(
                controller: addressFieldController,
                label: 'Address',
                hint: 'Enter your address',
                context: context
              ),
              SizedBox(height: screenHeight*0.02),
              // Street TextField
              _buildTextField(
                controller: streetController,
                label: 'Street',
                hint: 'Enter street name',
                context: context
              ),
              SizedBox(height: screenHeight*0.02),

              // Apartment TextField
              _buildTextField(
                controller: apartmentController,
                label: 'Apartment',
                hint: 'Enter apartment number or name',
                context: context
              ),
              SizedBox(height: screenHeight*0.02),

              // Postal Code TextField
              _buildTextField(
                controller: postalCodeController,
                label: 'Postal Code',
                hint: 'Enter postal code',
                context: context
              ),
              SizedBox(height: screenHeight*0.02),

              // Label Selector
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildLabelButton('HOME'),
                  _buildLabelButton('WORK'),
                  _buildLabelButton('OTHER'),
                ],
              ),
              const SizedBox(height: 20),

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
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              )),
              const SizedBox(height: 16),

              // Add Button
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.00),
                child: SizedBox(
                  width: double.infinity,
                  height: screenWidth*0.13,
                  child: ElevatedButton(
                    onPressed: () {
                      // Call the createAddress function from the controller
                      addressController.createAddress(
                        addressFieldController,
                        streetController,
                        apartmentController,
                        postalCodeController,
                        selectedLabel, // Use the state variable for label
                        addressController.isDefault.value,
                      );
                      Get.back(); // Go back after adding
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

  // Label Button Widget with dynamic background color
  Widget _buildLabelButton(String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLabel = label; // Update the state variable
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: selectedLabel == label
              ? AppTheme.lightTheme(context).primaryColor // Highlight selected label
              : AppTheme.bgGrey, // Default background color
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Text(
          label,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: selectedLabel == label ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required BuildContext context
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 12),
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: screenWidth*0.13, // Reduced height for the TextField
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppTheme.bgGrey, // Set your desired background color
              hintText: hint,
              contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8), // Reduced corner radius
                borderSide: BorderSide.none, // No visible border
              ),
            ),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14),
          ),
        ),
      ],
    );
  }

}
