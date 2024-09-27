import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const MyButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.symmetric(
          vertical: 12, horizontal: 20), // Consistent padding
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(8)), // Rounded corners for better UI
      child: Text(
        text,
        style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold), // Button text styling
      ),
    );
  }
}
