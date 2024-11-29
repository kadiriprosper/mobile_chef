import 'package:flutter/material.dart';

class CustomExternalAuthButton extends StatelessWidget {
  const CustomExternalAuthButton(
      {super.key,
      required this.buttonLabel,
      required this.icon,
      required this.onPressed,
      this.color});

  final String buttonLabel;
  final Widget icon;
  final VoidCallback onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Colors.orange),
      ),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(width: 6),
          Text(
            buttonLabel,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: color ?? Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
