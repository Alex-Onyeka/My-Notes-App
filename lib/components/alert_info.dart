import 'package:flutter/material.dart';

class AlertInfo extends StatefulWidget {
  final String title;
  final String message;
  const AlertInfo({
    super.key,
    required this.title,
    required this.message,
  });

  @override
  State<AlertInfo> createState() => _AlertInfoState();
}

class _AlertInfoState extends State<AlertInfo> {
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
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            style: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
            widget.message,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            spacing: 10,
            children: [
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
