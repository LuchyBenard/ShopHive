import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shophive/models/product_model.dart';
import 'package:shophive/providers/cart_provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel product;

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1; // tracks the quantity
  bool _isFavorite = false; // tracks the favorite

  @override
  Widget build(BuildContext context) {
    // FIX: You must initialize the provider here to use it below
    final cartProvider = Provider.of<CartProvider>(context);

    const deepBrown = Color(0xFF3E1C00);
    const amber = Color(0xFFF4A300);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // --- TOP BAR ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back Arrow
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: deepBrown,
                        size: 18,
                      ),
                    ),
                  ),
                  // Title
                  const Text(
                    'Product detail',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: deepBrown,
                    ),
                  ),
                  // Favorite Icon
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isFavorite = !_isFavorite;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: _isFavorite ? Colors.red : Colors.grey,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // --- SCROLLABLE CONTENT ---
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // PRODUCT IMAGE
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          widget.product.image,
                          width: double.infinity,
                          height: 350,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: double.infinity,
                              height: 350,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Icon(
                                Icons.shopping_bag_outlined,
                                size: 80,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // CATEGORY BADGE
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: amber.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              widget.product.category,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: amber,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // PRODUCT NAME
                          Text(
                            widget.product.name,
                            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: deepBrown),
                          ),
                          const SizedBox(height: 12),

                          // RATING + REVIEW COUNT
                          Row(
                            children: [
                              Row(
                                children: List.generate(5, (index) {
                                  return Icon(
                                    index < widget.product.rating.floor()
                                        ? Icons.star
                                        : index < widget.product.rating
                                        ? Icons.star_half
                                        : Icons.star_border,
                                    color: amber,
                                    size: 18,
                                  );
                                }),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                widget.product.rating.toString(),
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '(${widget.product.reviewCount})',
                                style: const TextStyle(fontSize: 13, color: Colors.grey),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // PRICE
                          Text(
                            '\$${widget.product.price.toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: deepBrown),
                          ),
                          const SizedBox(height: 16),
                          Divider(color: Colors.grey.shade200),
                          const SizedBox(height: 16),

                          // DESCRIPTION
                          const Text(
                            'Description',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: deepBrown),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.product.description.isEmpty ? 'No description available.' : widget.product.description,
                            style: const TextStyle(fontSize: 14, color: Colors.grey, height: 1.6),
                          ),
                          const SizedBox(height: 24),

                          // QUANTITY + ADD TO CART
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Quantity selector
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (_quantity > 1) setState(() => _quantity--);
                                    },
                                    child: Container(
                                      width: 36,
                                      height: 36,
                                      decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
                                      child: const Icon(Icons.remove, size: 18, color: deepBrown),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Text(
                                    _quantity.toString(),
                                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: deepBrown),
                                  ),
                                  const SizedBox(width: 16),
                                  GestureDetector(
                                    onTap: () => setState(() => _quantity++),
                                    child: Container(
                                      width: 36,
                                      height: 36,
                                      decoration: BoxDecoration(color: amber, borderRadius: BorderRadius.circular(8)),
                                      child: const Icon(Icons.add, size: 18, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                              // Add to cart button
                              ElevatedButton.icon(
                                onPressed: () {
                                  cartProvider.addToCart(widget.product, _quantity);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('${widget.product.name} added to cart!'),
                                      backgroundColor: deepBrown,
                                      behavior: SnackBarBehavior.floating,
                                      duration: const Duration(seconds: 1),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: deepBrown,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                                icon: const Icon(Icons.shopping_cart_outlined, size: 18),
                                label: Text(
                                  cartProvider.isInCart(widget.product.id) ? 'Added to Cart' : 'Add to Cart',
                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}