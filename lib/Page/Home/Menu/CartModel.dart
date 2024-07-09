import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  List<Map<String, String>> _cartItems = [];

  List<Map<String, String>> get cartItems => _cartItems;

  void addToCart(Map<String, String> item) {
    // Ensure the price is included in the item map
    // Assuming 'price' is a key in your item map
    if (!item.containsKey('price')) {
      throw Exception('Item must contain a price key');
    }

    _cartItems.add(item);
    notifyListeners(); // Notify listeners that the cart has been updated
  }

  void removeFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners(); // Notify listeners that the cart has been updated
  }

  void updateCartItem(int index, Map<String, String> newItem) {
    // Ensure the price is included in the item map
    // Assuming 'price' is a key in your item map
    if (!newItem.containsKey('price')) {
      throw Exception('Item must contain a price key');
    }

    _cartItems[index] = newItem;
    notifyListeners(); // Notify listeners that the cart has been updated
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners(); // Notify listeners that the cart has been updated
  }
}
