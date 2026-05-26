import 'package:flutter/material.dart';
import 'package:shophive/models/product_model.dart';

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
    const deepBrown = Color(0xFF3E1C00);
    const amber = Color(0xFFF4A300);

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
                    // Back Arrow
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: deepBrown,
                          size: 18,
                        ),
                      ),
                    ),
                    // Title
                    Text(
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
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(color: Colors.grey.shade100,
    shape: BoxShape.circle),

                      child: Icon(
                        _isFavorite
                        ? Icons.favorite : Icons.favorite_border,
                        color: _isFavorite ? Colors.red : Colors.grey,
                        size: 18,
                      ),
                    ),
                      ),
                  ],
                ),
              ),

              // SCROLLABLE CONTENT
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
    height: 280,
    fit: BoxFit.cover,
    errorBuilder: (context, error, stackTrace) {
    return Container(
    width: double.infinity,
    height: 280,
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
    padding: EdgeInsets.symmetric(
    horizontal: 12,
    vertical: 4,
    ),
    decoration: BoxDecoration(
    color: amber.withOpacity(0.15),
      borderRadius: BorderRadius.circular(20),
    ),
      child: Text(
        widget.product.category,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: amber,
        ),
      ),
    ),
      SizedBox(height: 12),

      // PRODUCT NAME
      Text(
          widget.product.name,
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: deepBrown),
      ),
      SizedBox(height: 12),

      //RATING + REVIEW COUNT
      Row(
        children: [
          // star icons
          Row(
            children: List.generate(5, (index) {
        return Icon(
          index < widget.product.rating.floor()
              ? Icons.start
              : index < widget.product.rating
              ? Icons.star_half
              : Icons.star_border,
          size: 18,
        );
      }),
          ),
          SizedBox(width: 8),

          // RATING NUMBER
          Text(
            widget.product.rating.toString(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          SizedBox(width: 4),

          // Review Count
          Text(
            '(${widget.product.reviewCount})',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),
        ],
      ),
      SizedBox(height: 16),

      // Price
      Text(
        '\$${widget.product.price.toStringAsFixed(2)}',
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: deepBrown,
        ),
      ),
                SizedBox(height: 16),

                //DIVIDER
                Divider(color: Colors.grey.shade200),
                SizedBox(height: 16),

                // DESCRIPTION
                Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: deepBrown,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  widget.product.description.isEmpty
                      ? 'No description available.'
                      : widget.product.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    height: 1.6,
                  ),
                ),
                SizedBox(height: 24),

                // Quantity Selector + Add to Cart
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Quantity selector
                    Row(
                      children: [
                        // Minus Button
                        GestureDetector(
                          onTap: () {
                            if (_quantity > 1) {
                              setState(() {
                                _quantity--;
                              });
                            }
                          },
                          child: Container(
                            width: 36,
                              height: 36,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(8)
                            ),
                            child: Icon(Icons.remove, size: 18, color: deepBrown),
                          ),
                          ),
                        SizedBox(width: 16),
      // Plus Button
      GestureDetector(
        onTap: () {
          setState(() {
            _quantity++;
          });
        },
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: amber,
            borderRadius: BorderRadius.circular(8),
          ),
        child: Icon(
          Icons.add,
          size: 18,
          color: Colors.white,
        ),
      ),
                        ),
                      ],
                    ),
                    // Add to cart button (half width)
                    ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Add product to cart
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '{widget.product.name} added to cart!',
                            ),
                            backgroundColor: deepBrown,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: deepBrown,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: Icon(
                        Icons.shopping_cart_outlined,
                        size: 18,
                      ),
                      label: Text(
                        'Add to Cart',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32),
                ],
      ),
    ),
    ],
    ),
              ),
              )
            ],
          )
      ),
    );
  }
}
