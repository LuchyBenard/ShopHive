import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shophive/providers/cart_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _selectAll = true;
  final Set<String> _selectedIds = {}

  @override
  void didChangedependencies() {
    super.didChangeDependencies();
    // select all items by default when screen loads
    final CartProvider = Provider.of<CartProvider>(content, listen: false);
    _selectedIds.addAll(
      cartProvider.cartItems.map((item) => item.product.id),
    );
  }

  // Calculate total of selected items only
  double _selectedTotal(CartProvider cartProvider) {
    return cartProvider.cartItems
        .where((item) => _selectedIds.contains(item.product.id))
        .fold(0, sum, item) => sum + item.totalPrice);
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
    fontWeight: Fontweight.w600,
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
    color: selectedCount > 0 ? deepBrown : Colors.grey.shade200,
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
        for (final id  in _selectedIds.toList()) {
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
    padding: EdgeInsets.all(16),
    itemCount: cartProvider.cartItems.length,
    itemBuilder: (context, index) {
      final item = cartProvider.cartItems[index];
      final isSelected = _selectedIds.contains(item.product.id);
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
    padding:
    )
          ],
        ),
      ),
    );
  }
}
