import 'package:flutter/material.dart';
import 'package:mynotes/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class MenuItemList extends StatefulWidget {
  final String title;
  final IconData icon;
  final bool isSwitch;
  // final QueryDocumentSnapshot<Map<String, dynamic>> user;
  final Function()? onTap;
  final IconData trailingIcon;
  const MenuItemList({
    super.key,
    required this.title,
    required this.isSwitch,
    required this.icon,
    // required this.user,
    required this.onTap,
    required this.trailingIcon,
  });

  @override
  State<MenuItemList> createState() => _MenuItemListState();
}

class _MenuItemListState extends State<MenuItemList> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 30.0,
          top: 20,
          bottom: 20,
          right: 20,
        ),
        child: Row(
          spacing: 15,
          children: [
            Icon(
              color: Theme.of(context).colorScheme.tertiary,
              size: 22,
              widget.icon,
            ),
            Expanded(
              child: Text(
                style: TextStyle(
                  letterSpacing: 1.5,
                  color:
                      Theme.of(
                        context,
                      ).colorScheme.secondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                widget.title.toUpperCase(),
              ),
            ),
            Visibility(
              visible: widget.isSwitch,
              child: Switch(
                value:
                    context
                        .watch<ThemeProvider>()
                        .isDarkMode,
                onChanged: (newValue) {
                  context
                      .read<ThemeProvider>()
                      .changeTheme();
                },
              ),
            ),
            Visibility(
              visible: !widget.isSwitch,
              child: Icon(
                size: 20,
                color:
                    Theme.of(context).colorScheme.tertiary,
                widget.trailingIcon,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
