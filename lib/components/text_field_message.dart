import 'package:flutter/material.dart';

class TextFieldMessage extends StatelessWidget {
  final String? value;
  final int maxLines;
  final String? hint;
  final IconData? icon;
  final TextEditingController controller;
  const TextFieldMessage({
    super.key,
    this.hint,
    required this.controller,
    this.icon,
    required this.maxLines,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      textCapitalization:
          maxLines == 1
              ? TextCapitalization.words
              : TextCapitalization.sentences,
      controller: controller,
      maxLines: maxLines,
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
