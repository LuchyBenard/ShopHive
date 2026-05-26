import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shophive/providers/product_provider.dart';
import 'package:shophive/widgets/product_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'Electronics',
    'Fashion',
    'Beauty',
    'Gadgets',
    'Accessories',
    'Books',
    'Utensils',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    const deepBrown = Color(0xFF3E1C00);
    const amber = Color(0xFFF4A300);

    // If user typed something → use search results
    // If category selected → filter by category
    // Otherwise → show all products
    final displayProducts = _searchController.text.isNotEmpty
        ? productProvider.searchResults
        : _selectedCategory == 'All'
        ? productProvider.products
        : productProvider.getByCategory(_selectedCategory);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Bar

            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 12,
              ),
              child: Row(
                children: [
                  // Search field
                  Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextField(
                          controller: _searchController,
                          autofocus: false,
                          onChanged: (value) { // Added 'value' parameter here
                            productProvider.updateSearchQuery(value);
                            setState(() {});
                          },
                          decoration: InputDecoration(
                            hintText: 'Search products...',
                              hintStyle: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 14,
                              ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.grey.shade500,
                            ),
                            // show a clearer button when users type
                            suffixIcon: _searchController.text.isNotEmpty? IconButton(
                              icon: Icon(
                                Icons.close,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                _searchController.clear();
                                productProvider.updateSearchQuery('');
                                setState(() {});
                              },
                            )
                                : null,
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                          ),
                        ),
                      ),
                  ),
                  ],
              ),
            ),

            // category filter chips
            SizedBox(
              height: 36,
              child: ListView.builder( // Changed to ListView.builder
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  // Fixed variable name to _selectedCategory
                  final isSelected = _selectedCategory == category;


                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = category;
                        // clear search when switching category
                        _searchController.clear();
                        productProvider.updateSearchQuery('');
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 8),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? amber : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'category',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600
                          color: isSelected ? Colors.white : Colors.black54,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 16,)
            // Results Count
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '${displayProducts.length} Products found',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 12),

            // Product Grid

            Expanded(
              child: displayProducts.isEmpty ? _buildEmptyState() : GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.72,
                ),
                itemCount: displayProducts.length,
                itemBuilder: (context, index) {
                  final product = displayProducts[index];
                  return ProductCard(product: product);
                }
              ),
            ),
          ],
        ),
      ),
    );
  }

  // EMPTY STATE WIDGET

Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 80,
            color: Colors.grey.shade300,
          ),
          SizedBox(height: 16),
          Text(
              'No Product Found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: 8),

          Text(
              'Try searching with different keywords',
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
