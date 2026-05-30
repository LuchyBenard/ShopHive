import 'package:flutter/material.dart';
import 'package:shophive/models/cart_model.dart';
import 'package:shophive/models/product_model.dart';

class CartProvider extends ChangeNotifier {
  // list of cart items
  final List<CartModel> _cartItems = [];

  // getters
// get all cart items
List<CartModel> get cartItems => _cartItems;

// get total number of items in cart
int get cartCount => _cartItems.length;

// get total price of all items
double get totalPrice {
  return _cartItems.fold(
    0,
      (sum, item) => sum + item.totalPrice,
  );
}

// get total price + shipping
double get totalWithShipping {
  return _cartItems.isEmpty ? 0 : totalPrice + 5.0;
}

// Add to cart
void addToCart(ProductModel product, int quantity) {
  // check if product already exists in cart
  final existingIndex = _cartItems.indexWhere(
      (item) => item.product.id == product.id,
  );
  if (existingIndex != -1) {
    // product already in cart, just increase quantity
    _cartItems[existingIndex].quantity += quantity;
  } else {
    // new product, add to cart
    _cartItems.add(
      CartModel(
        product: product,
        quantity: quantity,
      )
    );
  }
  notifyListeners();
}

// Remove from cart
void removeFromCart(String productId) {
  _cartItems.removeWhere(
      (item) => item.product.id == productId,
  );
  notifyListeners();
}

// Increase quantity
void increaseQuantity(String productId) {
  final index = _cartItems.indexWhere(
      (item) => item.product.id == productId,
  );
  if (index != -1) {
    _cartItems[index].quantity++;
    notifyListeners();
  }
}

// decrease quantity
void decreaseQuantity(String productId) {
  final index = _cartItems.indexWhere(
      (item) => item.product.id == productId,
  );
  if (index != -1) {
    if (_cartItems[index].quantity > 1) {
      // decrease if more than 1
      _cartItems[index].quantity--;
    } else {
      // remove item if quantity reaches 0
      _cartItems.removeAt(index);
    }
    notifyListeners();
  }
}

// clear entire cart
void clearCart() {
  _cartItems.clear();
  notifyListeners();
}

// check if product is in cart
bool isInCart(String productId) {
  return _cartItems.any(
        (item) => item.product.id == productId,
  );
}
}
