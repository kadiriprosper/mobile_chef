import 'package:flutter/material.dart';

class CustomAuthButton extends StatelessWidget {
  const CustomAuthButton({
    super.key,
    required this.onTap,
    required this.label,
    required this.filled,
  });

  final VoidCallback onTap;
  final String label;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      color: filled ? Colors.orange.shade500 : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: filled
            ? BorderSide.none
            : BorderSide(
                color: Colors.orange.shade500,
                width: 1.5,
              ),
      ),
      height: 60,
      minWidth: MediaQuery.of(context).size.width,
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
