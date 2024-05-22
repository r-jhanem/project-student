import 'package:flutter/material.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar({
    super.key,
    this.title,
    this.backgroundColor,
    this.foregroundColor,
    this.actions,
    this.shape,
    this.bottom,
  });

  final String? title;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final List<Widget>? actions;
  final ShapeBorder? shape;
  final PreferredSizeWidget? bottom;

  static double defaultHeight = 64.0;

  @override
  Size get preferredSize =>
      Size.fromHeight(defaultHeight + (bottom?.preferredSize.height ?? 0.0));

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title != null ? Text(title!) : null,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
            color: foregroundColor,
          ),
      actions: actions,
      shape: shape,
      iconTheme: Theme.of(context).appBarTheme.iconTheme?.copyWith(
            color: foregroundColor,
          ),
      bottom: bottom,
    );
  }
}
