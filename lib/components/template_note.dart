import 'package:flutter/material.dart';

class TemplateNote extends StatefulWidget {
  final String type;
  final bool showDelete;
  final bool isEdit;
  final String text;
  final Function()? editNote;
  final Function()? delete;
  const TemplateNote({
    super.key,
    required this.showDelete,
    required this.type,
    required this.editNote,
    required this.text,
    required this.isEdit,
    required this.delete,
  });

  @override
  State<TemplateNote> createState() => _TemplateNoteState();
}

class _TemplateNoteState extends State<TemplateNote> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 5.0,
          ),
          child: Container(
            padding: EdgeInsets.all(widget.isEdit ? 10 : 0),
            decoration: BoxDecoration(
              color:
                  widget.isEdit
                      ? Theme.of(
                        context,
                      ).colorScheme.surfaceContainer
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color:
                    widget.isEdit
                        ? Theme.of(
                          context,
                        ).colorScheme.tertiaryContainer
                        : Colors.transparent,
                width: widget.isEdit ? 1 : 0,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.start,
                  children: [
                    Visibility(
                      visible: widget.type == 'Header',
                      child: Flexible(
                        child: Text(
                          style: TextStyle(
                            color:
                                Theme.of(
                                  context,
                                ).colorScheme.primary,
                            fontSize:
                                widget.text.length < 50
                                    ? 22
                                    : widget.text.length >
                                            50 &&
                                        widget.text.length <
                                            80
                                    ? 20
                                    : 18,
                            fontWeight: FontWeight.bold,
                          ),
                          widget.text,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: widget.type == 'Title',
                      child: Flexible(
                        child: Text(
                          style: TextStyle(
                            color:
                                Theme.of(
                                  context,
                                ).colorScheme.primary,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          widget.text,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: widget.type == 'Sub-title',
                      child: Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 10.0,
                          ),
                          child: Text(
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:
                                  Theme.of(
                                    context,
                                  ).colorScheme.primary,
                              fontSize: 17,
                            ),
                            widget.text,
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: widget.type == 'Paragraph',
                      child: Flexible(
                        child: Text(
                          style: TextStyle(
                            color:
                                Theme.of(
                                  context,
                                ).colorScheme.primary,
                            fontSize: 15,
                          ),
                          widget.text,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: widget.isEdit,
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 10.0,
              right: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              spacing: 10,
              children: [
                Visibility(
                  visible: widget.showDelete,
                  child: Container(
                    padding: EdgeInsets.only(bottom: 2),
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color:
                          Theme.of(
                            context,
                          ).colorScheme.tertiaryContainer,
                      borderRadius: BorderRadius.circular(
                        100,
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 3,
                          color: const Color.fromARGB(
                            30,
                            0,
                            0,
                            0,
                          ),
                          spreadRadius: 2,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: widget.delete,
                      icon: Icon(
                        size: 22,
                        color:
                            Theme.of(
                              context,
                            ).colorScheme.primary,
                        Icons.delete_outline_rounded,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 2),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color:
                        Theme.of(
                          context,
                        ).colorScheme.tertiaryContainer,
                    borderRadius: BorderRadius.circular(
                      100,
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 3,
                        color: const Color.fromARGB(
                          30,
                          0,
                          0,
                          0,
                        ),
                        spreadRadius: 2,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    onPressed: widget.editNote,
                    icon: Icon(
                      size: 28,
                      color:
                          Theme.of(
                            context,
                          ).colorScheme.primary,
                      Icons.edit_note_rounded,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
