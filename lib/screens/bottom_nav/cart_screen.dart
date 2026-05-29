import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shophive/models/cart_model.dart';
import 'package:shophive/providers/cart_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _selectAll = true;
  final Set<String> _selectedIds = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // select all items by default when screen loads
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    _selectedIds.addAll(
      cartProvider.cartItems.map((item) => item.product.id),
    );
  }

  // Calculate total of selected items only
  double _selectedTotal(CartProvider cartProvider) {
    return cartProvider.cartItems
        .where((item) => _selectedIds.contains(item.product.id))
        .fold(0, (sum, item) => sum + item.totalPrice);
  }

  // Toggle select all
  void _toggleSelectAll(CartProvider cartProvider) {
    setState(() {
      if (_selectAll) {
        _selectedIds.clear();
        _selectAll = false;
      } else {
        _selectedIds.addAll(
          cartProvider.cartItems.map((item) => item.product.id),
        );
        _selectAll = true;
      }
    });
  }

  // Toggle single item
  void _toggleItem(String productId, CartProvider cartProvider) {
    setState(() {
      if (_selectedIds.contains(productId)) {
        _selectedIds.remove(productId);
      } else {
        _selectedIds.add(productId);
      }
      _selectAll = _selectedIds.length == cartProvider.cartItems.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    const deepBrown = Color(0xFF3E1C00);
    const amber = Color(0xFFF4A300);
    final selectedTotal = _selectedTotal(cartProvider);
    final selectedCount = _selectedIds.length;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // TOP BAR
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'My Cart',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: deepBrown,
                    ),
                  ),
                  // item  count badge
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: amber.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${cartProvider.cartCount} items',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: amber,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // SELECT ALL + SELECTED
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: Row(
                children: [
                  // CheckBox
                  GestureDetector(
                    onTap: () => _toggleSelectAll(cartProvider),
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: _selectAll ? deepBrown : Colors.grey,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: _selectAll ? deepBrown : Colors.grey,
                          width: 2,
                        ),
                      ),
                      child: _selectAll
                          ? Icon(
                        Icons.check,
                        size: 14,
                        color: Colors.white,
                      )
                          : null,
                    ),
                  ),
                  SizedBox(width: 8),
                  // All Text
                  GestureDetector(
                    onTap: () => _toggleSelectAll(cartProvider),
                    child: Text(
                      'All',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: _selectAll ? deepBrown : Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),

                  // Selected count badge
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: selectedCount > 0 ? deepBrown : Colors.grey
                          .shade200,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Selected ($selectedCount)',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: selectedCount > 0 ? Colors.white : Colors.grey,
                      ),
                    ),
                  ),
                  Spacer(),
                  // Remove selected button
                  if (selectedCount > 0)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          for (final id in _selectedIds.toList()) {
                            cartProvider.removeFromCart(id);
                          }
                          _selectedIds.clear();
                          _selectAll = false;
                        });
                      },
                      child: Text(
                        'Remove',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                ],
              ),
            ),
            Divider(height: 1),

            // CART ITEMS LIST
            Expanded(
              child: cartProvider.cartItems.isEmpty
                  ? _buildEmptyCart()
                  : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: cartProvider.cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartProvider.cartItems[index];
                  final isSelected =
                  _selectedIds.contains(item.product.id);
                  return _buildCartItem(
                    item,
                    isSelected,
                    cartProvider,
                    deepBrown,
                    amber,
                  );
                },
              ),
            ),


            // TOTAL + CHECKOUT
            if (cartProvider.cartItems.isNotEmpty)
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, -4),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    // Subtotal
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Subtotal',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),

                        Text(
                          '\$${selectedTotal.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 14, color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),

                    // Shipping
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Shipping',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          selectedCount > 0 ? '\$5.00' : '\$0.00',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF3E1C00),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),

                    // Checkout button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: selectedCount > 0 ? () {} : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: deepBrown,
                          foregroundColor: Colors.white
                          disabledBackgroundColor: Colors.grey.shade300,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          selectedCount > 0
                              ? 'Checkout ($selectedCount items)'
                              : 'Select items to checkout',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Cart Item Widget
  Widget _buildCartItem(
      CartModel item,
      bool isSelected,
      CartProvider cartProvider,
      Color deepBrown,
      Color amber,
      ) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected
              ? deepBrown.withOpacity(0, 3) : Colors.grey.shade200,
          width: isSelected ? 1.5 : 1,
        ),
      ),
      child: Row(
        children: [
          // checkbox
          GestureDetector(
            onTap: () => _toggleItem(item.product.id, cartProvider),
            child: Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: isSelected ? deepBrown : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: isSelected ? deepBrown : Colors.grey,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Icon(
                Icons.check,
                size: 14,
                color: Colors.white,
              )
                  : null,
            ),
          ),
          SizedBox(width: 12),

          // PRODUCT IMAGE
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              item.product.image,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.grey,
                  ),
                );
              },
            ),
          ),
          SizedBox(width: 12),
          //PRODUCT INFO
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
// Name + delete icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        item.product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIds.remove(item.product.id);
                          cartProvider.removeFromCart(item.product.id);
                        });
                      },
                      child: Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                // Category
                Text(
                  item.product.category,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 8),

                // price + selector
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
// price
                    Text(
                      '\$${item.totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3E1C00),
                      ),
                    ),

                    // Quantity Selector
                    Row(
                      children: [
                        // Minus Button
                        GestureDetector(
                          onTap: () {
                            cartProvider.decreaseQuantity(item.product.id);
                          },
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Icon(
                              Icons.remove,
                              size: 14,
                              color: deepBrown,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),

                        // Quantity Number
                        Text(
                          item.quantity.toString(),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(width: 8),

                        // Plus Button
                        GestureDetector(
                          onTap: () {
                            cartProvider.increaseQuantity(item.product.id);
                          },
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: amber,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Icon(
                              Icons.add,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Empty cart widget
  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 100,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            'Your cart is empty',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
    ),
        SizedBox(height: 8),
        Text(
          'Add items to your cart to get started',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
            ),
          );
  }
  }
