import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  String _email = '';
  String _password = '';
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;        // ← one variable, named consistently

  // Getters
  String get email => _email;
  String get password => _password;
  bool get obscurePassword => _obscurePassword;
  bool get obscureConfirmPassword => _obscureConfirmPassword;
  bool get isLoading => _isLoading; // ← getter returns _isLoading, not itself

  // Toggle password visibility
  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  // Toggle confirm password visibility
  void toggleConfirmPasswordVisibility() {
    _obscureConfirmPassword = !_obscureConfirmPassword;
    notifyListeners();
  }

  // Set email
  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  // Set password
  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  // Login
  Future<void> login(BuildContext context) async { // ← context added
    if (formKey.currentState!.validate()) {
      _isLoading = true;           // ← _isLoading not isLoading
      notifyListeners();

      // Simulate network request
      await Future.delayed(const Duration(seconds: 2));

      _isLoading = false;          // ← _isLoading not isLoading
      notifyListeners();
    }
  }

  // Forgot password
  Future<void> forgotPassword(BuildContext context) async { // ← context added
    if (formKey.currentState!.validate()) {
      _isLoading = true;           // ← _isLoading not isLoading
      notifyListeners();

      // Simulate network request
      await Future.delayed(const Duration(seconds: 2));

      _isLoading = false;          // ← _isLoading not isLoading
      notifyListeners();
    }
  }
}