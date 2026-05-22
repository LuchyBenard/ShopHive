import 'package:flutter/material.dart';

class PopupHelper {
  static void showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.white,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(message),
            ),
          ],
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ), // Fixed bracket alignment
        duration: const Duration(seconds: 3),
      ),
    );
  }

  // --- 2. FIXED SUCCESS DIALOG ---
  static void showSuccessDialog(
      BuildContext context,
      String title,
      String message,
      VoidCallback onContinue,
      ) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevents closing by clicking outside
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        // Display the icon
        icon: const Icon(
          Icons.check_circle_rounded,
          color: Color(0xFF3E1C00),
          size: 48,
        ),
        // Display the TITLE (This was missing!)
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        // Display the message
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.grey),
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                onContinue();           // Run navigation/logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3E1C00),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Continue'),
            ),
          ),
        ],
      ),
    );
  }
}