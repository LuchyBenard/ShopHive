import 'package:flutter/material.dart';
import 'package:shophive/models/cart_model.dart';

class CartItem extends StatelessWidget {
  final CartModel item;
  final bool isSelected;
  final VoidCallback onToggle;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onDelete;

  const CartItem({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onToggle,
    required this.onIncrement,
    required this.onDecrement,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    const deepBrown = Color(0xFF3E1C00);
    const amber = Color(0xFFF4A300);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? deepBrown : Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          // Checkbox logic
          GestureDetector(
            onTap: onToggle,
            child: Icon(
              isSelected ? Icons.check_box : Icons.check_box_outline_blank,
              color: isSelected ? deepBrown : Colors.grey,
            ),
          ),
          const SizedBox(width: 12),

          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(item.product.image, width: 60, height: 60, fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text('\$${item.product.price}', style: TextStyle(color: Colors.grey.shade600)),
              ],
            ),
          ),

          // Quantity Controls
          Row(
            children: [
              IconButton(onPressed: onDecrement, icon: const Icon(Icons.remove_circle_outline)),
              Text('${item.quantity}', style: const TextStyle(fontWeight: FontWeight.bold)),
              IconButton(onPressed: onIncrement, icon: const Icon(Icons.add_circle, color: amber)),
              IconButton(onPressed: onDelete, icon: const Icon(Icons.delete, color: Colors.red)),
            ],
          ),
        ],
      ),
    );
  }
}