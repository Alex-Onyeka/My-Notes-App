import 'package:flutter/material.dart';
import 'package:mynotes/components/menu_item_list.dart';

class ProfileMenuList extends StatefulWidget {
  final String title;
  final IconData icon;
  final Function()? onTap;
  final bool isSwitch;
  final IconData iconTrailing;
  const ProfileMenuList({
    super.key,
    required this.title,
    required this.icon,
    required this.iconTrailing,
    required this.isSwitch,
    required this.onTap,
  });

  @override
  State<ProfileMenuList> createState() =>
      _ProfileMenuListState();
}

class _ProfileMenuListState extends State<ProfileMenuList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:
            Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      child: MenuItemList(
        icon: widget.icon,
        isSwitch: widget.isSwitch,
        onTap: widget.onTap,
        title: widget.title,
        trailingIcon: widget.iconTrailing,
      ),
    );
  }
}
