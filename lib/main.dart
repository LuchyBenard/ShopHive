import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shophive/providers/auth_provider.dart';
import 'package:shophive/providers/product_provider.dart';
import 'package:shophive/screens/bottom_nav/bottom_nav_bar.dart';
import 'package:shophive/screens/splash_screen.dart';
import 'package:shophive/providers/cart_provider.dart';

void main() {
  runApp(const ShopHive());
}

class ShopHive extends StatelessWidget {
  const ShopHive({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => ProductProvider()),
    ChangeNotifierProvider(create: (_) => CartProvider()),
        ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      ),
    );
  }
}
