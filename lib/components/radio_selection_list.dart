import 'package:flutter/material.dart';
import 'package:mynotes/components/radio_button_list_tile.dart';
import 'package:mynotes/provider/main_provider.dart';
import 'package:provider/provider.dart';

class RadioSelectionList extends StatefulWidget {
  final List options;
  final bool isVertical;
  const RadioSelectionList({
    super.key,
    required this.options,
    required this.isVertical,
  });

  @override
  State<RadioSelectionList> createState() =>
      _RadioSelectionListState();
}

class _RadioSelectionListState
    extends State<RadioSelectionList> {
  // Holds the selected item

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        scrollDirection:
            widget.isVertical
                ? Axis.vertical
                : Axis.horizontal,
        itemCount: widget.options.length,
        itemBuilder: (context, index) {
          return RadioButtonListTile(
            onTap: () {
              String trimmedText = widget.options[index]
                  .replaceAll(" ", "");
              String finalText =
                  trimmedText
                      .substring(0, 1)
                      .toLowerCase() +
                  trimmedText.substring(
                    1,
                    trimmedText.length,
                  );

              context.read<MainProvider>().sort(finalText);
              context
                  .read<MainProvider>()
                  .changeSeletedOption(index);
            },
            value: index,
            selectedValue:
                context
                    .watch<MainProvider>()
                    .selectedOption,
            title: widget.options[index],
          );
        },
      ),
    );
  }
}
