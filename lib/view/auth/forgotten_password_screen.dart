import 'package:flutter/material.dart';

class ForgottenPasswordScreen extends StatefulWidget {
  const ForgottenPasswordScreen({super.key});

  @override
  State<ForgottenPasswordScreen> createState() =>
      _ForgottenPasswordScreenState();
}

class _ForgottenPasswordScreenState extends State<ForgottenPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: IconButton.filled(
                onPressed: () {},
                iconSize: 32,
                style: ButtonStyle(
                  minimumSize: const WidgetStatePropertyAll(Size(50, 50)),
                  backgroundColor: WidgetStatePropertyAll(
                    Colors.grey.shade200,
                  ),
                ),
                color: Colors.black,
                icon: const Icon(
                  Icons.arrow_back,
                ),
              ),
              // CircleAvatar(
              //   radius: 24,
              //   backgroundColor: Colors.grey.shade100,
              //   child: IconButton(onPressed: onPress, icon: icon),
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
