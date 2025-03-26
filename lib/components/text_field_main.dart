import 'package:flutter/material.dart';

class TextFieldMain extends StatefulWidget {
  final bool password;
  final bool notCapitalize;
  final String hint;
  final IconData icon;
  final TextEditingController controller;
  const TextFieldMain({
    super.key,
    required this.password,
    required this.notCapitalize,
    required this.hint,
    required this.controller,
    required this.icon,
  });

  @override
  State<TextFieldMain> createState() =>
      _TextFieldMainState();
}

class _TextFieldMainState extends State<TextFieldMain> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      textCapitalization:
          widget.notCapitalize || widget.password
              ? TextCapitalization.none
              : TextCapitalization.sentences,
      controller: widget.controller,
      obscureText: widget.password,
      autocorrect: false,
      autofocus: false,
      enableSuggestions: !widget.password,
      decoration: InputDecoration(
        prefixIcon: Icon(
          widget.icon,
          size: 20,
          color: Theme.of(context).colorScheme.tertiary,
        ), // Placing the icon inside
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
        hintText: widget.hint, // Optional: Add a hint text
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.tertiary,
          fontSize: 14,
        ),
      ),
    );
  }
}
