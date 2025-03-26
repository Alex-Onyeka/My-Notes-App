import 'package:flutter/material.dart';
import 'package:mynotes/components/radio_selection_list.dart';
import 'package:mynotes/provider/main_provider.dart';
import 'package:provider/provider.dart';

class SortingAlertBox extends StatefulWidget {
  const SortingAlertBox({super.key});

  @override
  State<SortingAlertBox> createState() =>
      _SortingAlertBoxState();
}

class _SortingAlertBoxState extends State<SortingAlertBox> {
  //
  List<String> options = [
    "Author",
    "Created Time",
    "Title",
  ];
  //
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          spacing: 5,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              style: TextStyle(
                color:
                    Theme.of(context).colorScheme.primary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              'Sort Your Notes',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  style: TextStyle(
                    color:
                        Theme.of(
                          context,
                        ).colorScheme.tertiary,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                  'Sort Notes By:',
                ),
              ],
            ),
          ],
        ),
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 170,
            child: RadioSelectionList(
              options: options,
              isVertical: true,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            spacing: 10,
            children: [
              MaterialButton(
                onPressed: () {
                  context.read<MainProvider>().sortMain();
                  Navigator.of(context).pop();
                },
                child: Text(
                  style: TextStyle(
                    color:
                        Theme.of(
                          context,
                        ).colorScheme.primary,
                  ),
                  'Proceed',
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
