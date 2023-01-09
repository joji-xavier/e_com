import 'package:flutter/material.dart';

class AppDraderItems extends StatelessWidget {
  final String title;
  final bool selected;
  final int index;
  final int id;
  final VoidCallback onPress;
  const AppDraderItems({
    Key? key,
    required this.title,
    required this.selected,
    required this.index,
    required this.id,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: selected && index == id,
      onTap: onPress,
      selectedTileColor: Colors.orange,
      title: Text(
        title,
        style: TextStyle(
            color: selected && index == id ? Colors.white : Colors.orange,
            fontSize: 20),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: selected && index == id ? Colors.white : Colors.orange,
        size: 15,
      ),
    );
  }
}
