import 'package:flutter/material.dart';

class AreYouSureAlertBox extends StatefulWidget {
  final String title;
  final String message;
  final Function()? onPressed;
  const AreYouSureAlertBox({
    super.key,
    required this.title,
    required this.message,
    required this.onPressed,
  });

  @override
  State<AreYouSureAlertBox> createState() =>
      _AreYouSureAlertBoxState();
}

class _AreYouSureAlertBoxState
    extends State<AreYouSureAlertBox> {
  bool isLoading = false;
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
          Stack(
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
                widget.message,
              ),
              Visibility(
                visible: isLoading,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(
                      25,
                      0,
                      0,
                      0,
                    ),
                  ),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.grey.shade500,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            spacing: 10,
            children: [
              MaterialButton(
                onPressed: () {
                  if (isLoading == false) {
                    setState(() {
                      isLoading = true;
                      widget.onPressed!();
                    });
                  } else {
                    return;
                  }
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
