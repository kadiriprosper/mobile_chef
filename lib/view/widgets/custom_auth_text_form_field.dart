import 'package:flutter/material.dart';

class CustomAuthTextFormField extends StatelessWidget {
  const CustomAuthTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.prefixIcon,
    required this.validator,
    required this.textInputType,
    this.suffixIcon,
    this.filled = true,
    this.obscureText = false,
  });

  final String hintText;
  final TextEditingController controller;
  final Widget prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? Function(String?) validator;
  final TextInputType textInputType;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: textInputType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) => validator(value),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(18),
        filled: filled,
        fillColor: filled ? const Color(0xFFFFF6ED) : Colors.white,
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey.shade600,
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.orange,
          ),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.orange,
          ),
        ),
      ),
    );
  }
}
