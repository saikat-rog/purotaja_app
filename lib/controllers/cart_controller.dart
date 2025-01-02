import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartController extends GetxController {
  final cartItems = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadCartItems(); // Load cart items when the controller is initialized
  }

  // Method to add an item to the cart
  void addToCart(Map<String, dynamic> item) async {
    // Check if the product already exists in the cart
    final index = cartItems.indexWhere((cartItem) => cartItem['id'] == item['id']);
    if (index != -1) {
      // If product exists, increase the quantity
      cartItems[index]['quantity'] += item['quantity'];
      cartItems.refresh(); // Notify observers about the change
    } else {
      // If product does not exist, add it to the cart
      cartItems.add(item);
    }
    await _saveCartItems(); // Save cart items to SharedPreferences
  }

  // Method to edit a cart item
  void editCartItem(int index, String key, dynamic newValue) async {
    if (index >= 0 && index < cartItems.length) {
      cartItems[index][key] = newValue; // Update the specific key with the new value
      cartItems.refresh(); // Notify observers about the change
      await _saveCartItems(); // Save cart items to SharedPreferences
    } else {
      if (kDebugMode) {
        print('Index out of range');
      }
    }
  }

  // Method to delete a cart item
  void deleteFromCart(int index) async {
    if (index >= 0 && index < cartItems.length) {
      cartItems.removeAt(index);
      cartItems.refresh();
      await _saveCartItems(); // Save cart items to SharedPreferences
    } else {
      if (kDebugMode) {
        print('Index out of range');
      }
    }
  }

  // Method to empty the cart
  void emptyCart() async {
    cartItems.clear();
    await _saveCartItems(); // Save cart items to SharedPreferences
  }

  // Increase quantity
  void increaseQuantity(int index) async {
    if (index >= 0 && index < cartItems.length) {
      cartItems[index]['quantity']++;
      if (cartItems[index]['quantity'] == 0) {
        deleteFromCart(index); // Remove item if quantity is 0
      } else {
        cartItems.refresh();
      }
      await _saveCartItems(); // Save updated cart items
    }
  }

  // Decrease quantity
  void decreaseQuantity(int index) async {
    if (index >= 0 && index < cartItems.length) {
      cartItems[index]['quantity']--;
      if (cartItems[index]['quantity'] == 0) {
        deleteFromCart(index); // Remove item if quantity is 0
      } else {
        cartItems.refresh();
      }
      await _saveCartItems(); // Save updated cart items
    }
  }

  // Save cart items to SharedPreferences
  Future<void> _saveCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final cartItemsJson = jsonEncode(cartItems.toList()); // Convert cart items to JSON string
    await prefs.setString('cart_items', cartItemsJson); // Store cart items
  }

  // Load cart items from SharedPreferences
  Future<void> _loadCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final cartItemsJson = prefs.getString('cart_items');
    if (cartItemsJson != null) {
      final List<dynamic> cartItemsList = jsonDecode(cartItemsJson);
      cartItems.assignAll(cartItemsList.cast<Map<String, dynamic>>()); // Load cart items from SharedPreferences
    }
  }
}
