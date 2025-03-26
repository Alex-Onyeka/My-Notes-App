import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final String title;
  final Function()? onTap;
  const Button({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          onTap: () {
            if (widget.onTap != null) {
              widget.onTap!();
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  widget.title,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
