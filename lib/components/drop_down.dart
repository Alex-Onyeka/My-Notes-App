import 'package:flutter/material.dart';

class DropDownMain extends StatefulWidget {
  const DropDownMain({super.key});

  @override
  State<DropDownMain> createState() => _DropDownMainState();
}

class _DropDownMainState extends State<DropDownMain> {
  String? selectedValue; // Selected dropdown value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DropdownButton<String>(
          hint: Text('Paragraph'), // Placeholder text
          value: selectedValue, // Selected item
          onChanged: (newValue) {
            setState(() {
              selectedValue = newValue;
            });
          },
          items:
              ["Title", "Sub-title", "Paragraph"]
                  .map(
                    (String item) =>
                        DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        ),
                  )
                  .toList(),
        ),
      ),
    );
  }
}
