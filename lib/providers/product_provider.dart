import 'package:flutter/material.dart';
import 'package:shophive/models/product_model.dart';

class ProductProvider extends ChangeNotifier{
  final List<ProductModel> _products = [
    ProductModel(
      id: '1',
      name: 'beach two piece',
      image: 'assets/images/beachwear1.jpg',
      price: 50,
      description: 'A cute two piece beach wear for the beautiful ladies',
      category: 'Fashion',
      rating: 4.5,
      reviewCount: 112,
        ),
    ProductModel(
      id: '2',
      name: 'crochet bag',
      image: 'assets/images/cutecrochetbag.jpg',
      price: 65,
      description: 'A cute pink crochet purse for the ladies',
      category: 'Fashion',
      rating: 4.5,
      reviewCount: 115,
    ),
    ProductModel(
      id: '3',
      name: 'Shiny Strap Stiletto Heels',
      image: 'assets/images/shoes.jpg',
      price: 120,
      description: 'Shiny Strap Contoured Stiletto heels - Silver 9.5cm Heels/39',
      category: 'Fashion',
      rating: 4.0,
      reviewCount: 123,
    ),
    ProductModel(
      id: '4',
      name: 'Smart Watch',
      image: 'assets/images/smartwatch.jpg',
      price: 200,
      description: '',
      category: 'Accessories',
      rating: 4.5,
      reviewCount: 90,
    ),
    ProductModel(
      id: '5',
      name: 'Face Moisturizer',
      image: 'assets/images/facecream.jpg',
      price: 60,
      description: '',
      category: 'Beauty',
      rating: 4.0,
      reviewCount: 102 ,
    ),
    ProductModel(
      id: '7',
      name: 'Tinted pink lipgloss',
      image: 'assets/images/',
      price: 10,
      description: '',
      category: 'Beauty',
      rating: 4.0,
      reviewCount: 112,
    ),
  ];

  // Search Query
String _searchQuery = '';

// Getters
String get searchQuery => _searchQuery;

// Get all Products
List<ProductModel> get products => _products;

// Get products by category
List<ProductModel> getByCategory(String category) {
  return _products
      .where((p) => p.category == category)
      .toList();
}
// Get featured products (top rated)
List<ProductModel> get featuredProducts {
  return _products
      .where((p) => p.rating >= 4.5)
      .toList();
}
// Search Products
List<ProductModel> get searchResults {
  if (_searchQuery.isEmpty) return [];
    return _products
        .where((p) => p.name.toLowerCase().contains(_searchQuery.toLowerCase()) || p.category.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
}
// Update search query
void updateSearchQuery(String query) {
  _searchQuery = query;
  notifyListeners();
}
// Get all categories
List<String> get categories {
  return _products
      .map((p) => p.category)
      .toSet()
      .toList();
}
}