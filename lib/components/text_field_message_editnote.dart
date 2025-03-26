import 'package:flutter/material.dart';

class TextFieldMessageEditnote extends StatelessWidget {
  final String? value;
  final String hint;
  final TextEditingController controller;
  TextFieldMessageEditnote({
    super.key,
    required this.hint,
    required this.controller,
    this.value,
  }) {
    controller.text = value ?? ''; // Set default value
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      textCapitalization: TextCapitalization.sentences,
      controller: controller,
      maxLines: 5,
      autocorrect: true,
      autofocus: false,
      enableSuggestions: true,

      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Color.fromARGB(56, 158, 158, 158),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color:
                Colors
                    .grey, // Highlight border when focused
            width: 2,
          ),
        ),
        hintText: hint, // Optional: Add a hint text
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.tertiary,
          fontSize: 14,
        ),
      ),
    );
  }
}
