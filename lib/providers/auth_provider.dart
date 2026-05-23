import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  bool obscureText = true;
  bool _obscureConfirmPassword = true;
  bool isLoad = false;

  // Getters
  String  get Email => email;
  String  get Password => password;
  bool  get ObscureText => obscureText;
  bool  get ObscureConfirmPassword => _obscureConfirmPassword;
  bool  get isLoading => isLoading;


  }
}
