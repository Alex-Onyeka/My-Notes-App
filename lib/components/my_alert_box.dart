import 'package:flutter/material.dart';
import 'package:mynotes/components/text_field_main.dart';
import 'package:mynotes/components/text_field_message.dart';

class MyAlertBox extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController noteController;
  final Function()? onPressed;
  const MyAlertBox({
    super.key,
    required this.noteController,
    required this.titleController,
    required this.onPressed,
  });

  @override
  State<MyAlertBox> createState() => _MyAlertBoxState();
}

class _MyAlertBoxState extends State<MyAlertBox> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Text(
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          'Create New Note',
        ),
      ),
      content: Column(
        spacing: 15,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFieldMain(
            notCapitalize: false,
            password: false,
            hint: 'Enter Your Title',
            controller: widget.titleController,
            icon: Icons.text_fields_rounded,
          ),
          TextFieldMessage(
            maxLines: 5,
            hint: 'Start Typing your First Paragraph',
            controller: widget.noteController,
            icon: Icons.text_fields_rounded,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            spacing: 10,
            children: [
              MaterialButton(
                onPressed: widget.onPressed,
                child: Text(
                  style: TextStyle(
                    color:
                        Theme.of(
                          context,
                        ).colorScheme.primary,
                  ),
                  'Add Note',
                ),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  widget.noteController.clear();
                  widget.titleController.clear();
                },
                child: Text(
                  style: TextStyle(
                    color:
                        Theme.of(
                          context,
                        ).colorScheme.secondary,
                  ),
                  'Cancel',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
