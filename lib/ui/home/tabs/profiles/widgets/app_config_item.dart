import 'package:flutter/material.dart';

class AppConfigItem extends StatelessWidget {
  final String text;
  final Widget icon;

  const AppConfigItem({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).highlightColor,
        border: Border.all(color: Theme.of(context).dividerColor, width: 2),
      ),
      child: ListTile(
        leading: Text(text, style: Theme.of(context).textTheme.headlineMedium),
        trailing: icon,
      ),
    );
  }
}
