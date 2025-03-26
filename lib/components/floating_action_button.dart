import 'package:flutter/material.dart';

class MyFloatingActionButton extends StatelessWidget {
  final IconData icon;
  final Function()? onTap;
  final String text;
  final bool isEdit;
  final bool isEditOn;
  const MyFloatingActionButton({
    super.key,
    required this.isEdit,
    required this.onTap,
    required this.icon,
    required this.text,
    required this.isEditOn,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Container(
          padding: EdgeInsets.fromLTRB(25, 10, 15, 10),
          decoration: BoxDecoration(
            color:
                Theme.of(
                  context,
                ).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(53, 0, 0, 0),
                blurRadius: 5,
                spreadRadius: 2,
                offset: Offset(1, 2),
              ),
            ],
          ),
          child: Row(
            spacing: 5,
            mainAxisSize: MainAxisSize.min,
            children: [
              Visibility(
                visible: !isEdit,
                child: Text(
                  style: TextStyle(
                    color:
                        Theme.of(
                          context,
                        ).colorScheme.inversePrimary,
                    fontWeight: FontWeight.bold,
                  ),
                  text,
                ),
              ),
              Visibility(
                visible: isEdit,
                child: Text(
                  style: TextStyle(
                    color:
                        Theme.of(
                          context,
                        ).colorScheme.inversePrimary,
                    fontWeight: FontWeight.bold,
                  ),
                  isEditOn ? 'Finish Edit' : text,
                ),
              ),
              Visibility(
                visible: !isEdit,
                child: Icon(
                  color:
                      Theme.of(
                        context,
                      ).colorScheme.inversePrimary,
                  icon,
                ),
              ),
              Visibility(
                visible: isEdit,
                child: Icon(
                  color:
                      Theme.of(
                        context,
                      ).colorScheme.inversePrimary,
                  isEditOn ? Icons.clear : icon,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
