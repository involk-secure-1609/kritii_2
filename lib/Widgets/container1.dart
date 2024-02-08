import 'package:flutter/material.dart';

class CommonContainer extends StatelessWidget {
  final List<Widget> children;
  const CommonContainer({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromRGBO(85, 85, 85, 1),
        borderRadius: const BorderRadius.all(Radius.circular(25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: children,
      ),
    );
  }
}
