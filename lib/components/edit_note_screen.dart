import 'package:flutter/material.dart';
import 'package:mynotes/components/text_field_message.dart';

class EditNoteScreen extends StatefulWidget {
  final TextEditingController noteController;
  final Function()? onPressed;
  const EditNoteScreen({
    super.key,
    required this.noteController,
    required this.onPressed,
  });

  @override
  State<EditNoteScreen> createState() =>
      _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 30),
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
            child: Column(
              spacing: 5,
              children: [
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      color: Colors.transparent,
                      Icons.close,
                    ),
                    Text(
                      style: TextStyle(
                        color:
                            Theme.of(
                              context,
                            ).colorScheme.primary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      'Edit Text Block',
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        color:
                            Theme.of(
                              context,
                            ).colorScheme.primary,
                        Icons.clear,
                      ),
                    ),
                  ],
                ),
                //
                SizedBox(height: 10),
                //
                Column(
                  spacing: 15,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment:
                      MainAxisAlignment.start,
                  children: [
                    TextFieldMessage(
                      maxLines:
                          (MediaQuery.of(
                                    context,
                                  ).size.height *
                                  0.53 ~/
                                  20)
                              .floor(),
                      hint: 'Start Typing your note...',
                      controller: widget.noteController,
                      icon: Icons.text_fields_rounded,
                    ),

                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      spacing: 10,
                      children: [
                        MaterialButton(
                          elevation: 0,
                          color:
                              Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                          onPressed: widget.onPressed,
                          child: Text(
                            style: TextStyle(
                              color:
                                  Theme.of(
                                    context,
                                  ).colorScheme.surface,
                            ),
                            'Save Note',
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            widget.noteController.clear();
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
