import 'package:flutter/material.dart';

import '../constants/skills.dart';

class SkillContainer extends StatelessWidget {
  final dynamic skill;
  final double? fontSize;
  const SkillContainer({super.key, required this.skill, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: skill is int
            ? SkillsComponents.getSkillColor(SkillsEnum.values[skill])
            : Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Text(
        skill is int ? SkillsEnum.values[skill].name : skill.toString(),
        style: TextStyle(
            fontSize: fontSize ?? 13,
            color: Colors.black,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}

class SkillsListView extends StatelessWidget {
  final List<dynamic> skillsList;
  const SkillsListView({super.key, required this.skillsList});

  @override
  Widget build(BuildContext context) {
    if (skillsList.length <= 5) {
      return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: skillsList.map((skill) {
            return SkillContainer(skill: skill);
          }).toList());
    }
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        Wrap(
            spacing: 8,
            runSpacing: 8,
            children: skillsList.take(4).map((skill) {
              return SkillContainer(skill: skill);
            }).toList()),
        ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                padding:
                const EdgeInsets.symmetric(vertical: 3, horizontal: 5)),
            child: Text(
              '+${skillsList.length - 4} More',
              style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                  fontWeight: FontWeight.w400),
            ))
      ],
    );
  }
}
