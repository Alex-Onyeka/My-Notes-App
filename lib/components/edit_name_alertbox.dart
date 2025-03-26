import 'package:flutter/material.dart';
import 'package:mynotes/components/text_field_main.dart';

class EditNameAlertbox extends StatefulWidget {
  final String title;
  final String hintMain;
  final String? hintConfirm;
  final bool isTwoTextFields;
  final String buttonText;
  final TextEditingController nameController;
  final TextEditingController? confirmPassword;
  final Function()? onPressed;
  const EditNameAlertbox({
    super.key,
    required this.nameController,
    required this.onPressed,
    required this.title,
    required this.hintMain,
    this.hintConfirm,
    required this.buttonText,
    required this.isTwoTextFields,
    this.confirmPassword,
  });

  @override
  State<EditNameAlertbox> createState() =>
      _EditNameAlertboxState();
}

class _EditNameAlertboxState
    extends State<EditNameAlertbox> {
  TextEditingController fake = TextEditingController();
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
          widget.title,
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
            hint: widget.hintMain,
            controller: widget.nameController,
            icon: Icons.text_fields_rounded,
          ),
          Visibility(
            visible: widget.isTwoTextFields,
            child: TextFieldMain(
              notCapitalize: false,
              password: false,
              hint: widget.hintConfirm ?? '',
              controller:
                  widget.isTwoTextFields == true
                      ? widget.confirmPassword!
                      : fake,
              icon: Icons.text_fields_rounded,
            ),
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
                  widget.buttonText,
                ),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  widget.nameController.clear();
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
