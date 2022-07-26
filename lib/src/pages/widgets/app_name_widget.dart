import 'package:flutter/material.dart';

class AppNameWidget extends StatelessWidget {
  final Color color;

  const AppNameWidget({
    Key? key,
    this.color = Colors.red,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "Green",
            style: TextStyle(color: color),
          ),
          const TextSpan(
            text: 'grocer',
            style: TextStyle(color: Colors.orange),
          ),
        ],
        style: const TextStyle(
          fontSize: 30,
        ),
      ),
    );
  }
}
