import 'package:flutter/material.dart';

class DetailsInfoTab extends StatefulWidget {
  final IconData icon;
  final Color? backGroundcolor;
  final Color? textColor;
  final Color? outlineColor;
  final String? text;
  final Function()? onTap;
  final bool isButton;
  const DetailsInfoTab({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
    required this.isButton,
    this.backGroundcolor,
    this.outlineColor,
    this.textColor,
  });

  @override
  State<DetailsInfoTab> createState() =>
      _DetailsInfoTabState();
}

class _DetailsInfoTabState extends State<DetailsInfoTab> {
  String cutText(String text) {
    if (text.length > 14) {
      return '${text.substring(0, 14)}...';
    } else {
      return text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.only(
          left: 10,
          right: 10,
          top: 7,
          bottom: 7,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color:
              widget.backGroundcolor != null
                  ? widget.backGroundcolor!
                  : Theme.of(
                    context,
                  ).colorScheme.surfaceContainer,
          border: Border.all(
            color:
                widget.backGroundcolor != null
                    ? widget.outlineColor!
                    : Theme.of(
                      context,
                    ).colorScheme.tertiaryContainer,
          ),
        ),
        child: Row(
          spacing: 0,
          children: [
            Icon(
              size: 18,
              color:
                  widget.backGroundcolor != null
                      ? widget.textColor!
                      : Theme.of(
                        context,
                      ).colorScheme.outline,
              widget.icon,
            ),
            SizedBox(width: 5),
            Expanded(
              child: Text(
                style: TextStyle(
                  color:
                      widget.backGroundcolor != null
                          ? widget.textColor!
                          : Theme.of(
                            context,
                          ).colorScheme.tertiary,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w500,
                ),
                cutText(widget.text ?? 'Text'),
              ),
            ),
            SizedBox(width: 2),
            Visibility(
              visible: widget.isButton,
              child: Icon(
                size: 13,
                color:
                    Theme.of(context).colorScheme.tertiary,
                Icons.arrow_forward_ios_rounded,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
