import 'package:chat_app/utils/theme.dart';
import 'package:flutter/material.dart';

class IconBackground extends StatelessWidget {
  const IconBackground({Key? key, required this.iconData, required this.onTap}) : super(key: key);

  final IconData iconData;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(6),
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        splashColor: AppColors.secondary,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Icon(iconData, size: 18),
        ),
      ),
    );
  }
}
