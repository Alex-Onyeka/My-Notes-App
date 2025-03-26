import 'package:flutter/material.dart';

class RadioButtonListTile extends StatefulWidget {
  final int value;
  final String title;
  final int selectedValue;
  final Function()? onTap;
  const RadioButtonListTile({
    super.key,
    required this.value,
    required this.onTap,
    required this.selectedValue,
    required this.title,
  });

  @override
  State<RadioButtonListTile> createState() =>
      _RadioButtonListTileState();
}

class T {}

class _RadioButtonListTileState
    extends State<RadioButtonListTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 0,
          vertical: 5,
        ),
        child: Row(
          spacing: 0,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color:
                      Theme.of(context).colorScheme.primary,
                  width: 1.5,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(6.5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                      color:
                          widget.selectedValue !=
                                  widget.value
                              ? Colors.transparent
                              : Theme.of(
                                context,
                              ).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              style: TextStyle(
                color:
                    Theme.of(context).colorScheme.secondary,

                fontWeight: FontWeight.w500,
              ),
              widget.title,
            ),
          ],
        ),
      ),
    );
  }
}
