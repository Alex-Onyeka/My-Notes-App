import 'package:flutter/material.dart';

class NoteListTile extends StatefulWidget {
  final String title;
  final String createdTime;
  final Function()? onTap;
  const NoteListTile({
    super.key,
    required this.title,
    required this.createdTime,
    required this.onTap,
  });

  @override
  State<NoteListTile> createState() => _MyListTileState();
}

class _MyListTileState extends State<NoteListTile> {
  //
  //
  String cutText(String text) {
    if (text.length > 20) {
      return '${text.substring(0, 20)}...'.toUpperCase();
    } else {
      return text.toUpperCase();
    }
  }

  //
  //
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 30,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color:
              Theme.of(
                context,
              ).colorScheme.surfaceContainer,
        ),
        child: ListTile(
          trailing: Icon(
            size: 20,
            color: Theme.of(context).colorScheme.tertiary,
            Icons.arrow_forward_ios_rounded,
          ),
          contentPadding: EdgeInsets.fromLTRB(30, 5, 20, 5),
          title: Text(
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
            cutText(widget.title),
          ),
          subtitle: Text(
            style: TextStyle(
              color:
                  Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
            widget.createdTime,
          ),
        ),
      ),
    );
  }
}
