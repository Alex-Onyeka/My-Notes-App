import 'package:flutter/material.dart';
import 'package:mynotes/components/drop_down.dart';
import 'package:mynotes/components/text_field_message_editnote.dart';

class EditNoteAlertBox extends StatefulWidget {
  final TextEditingController noteController;
  final Function()? onPressed;
  const EditNoteAlertBox({
    super.key,
    required this.noteController,
    required this.onPressed,
  });

  @override
  State<EditNoteAlertBox> createState() =>
      _EditNoteAlertBoxState();
}

class _EditNoteAlertBoxState
    extends State<EditNoteAlertBox> {
  List types = ['Title', 'Sub-Title', 'Paragraph'];
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
          'Edit Note',
        ),
      ),
      content: Column(
        spacing: 15,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFieldMessageEditnote(
            controller: widget.noteController,
            hint: 'Enter your note',
            value: widget.noteController.text,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 10,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [Text('Save Type:')],
              ),
              SizedBox(height: 30, child: DropDownMain()),
            ],
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
                  'Save Note',
                ),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
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
