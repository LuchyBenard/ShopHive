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
                  ],
              ),
            ),
          ],
        )
      ),
    );
  }
}
