import 'package:shophive/models/product_model.dart';

class CartModel {
  final ProductModel product;
  int quantity;

  CartModel({
    required this.product,
    this.quantity = 1,
});

  // Total price for this cart item
// for example, shoes $120 * 2 = $240
double get totalPrice => product.price * quantity;
}