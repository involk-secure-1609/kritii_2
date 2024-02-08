import 'package:flutter/material.dart';

enum SkillsEnum {
  c,
  cpp,
  cSharp,
  java,
  python,
  ruby,
  swift,
  kotlin,
  javascript,
  typescript,
  go,
  rust,
  dart,
  php,
  html,
  css,
  r,
  matlab,
  shell,
  sql,
  scala,
  groovy,
  perl,
  lua,
  vbNet,
}

class SkillsComponents {
  static Color getSkillColor(SkillsEnum value) {
    final List<String> skillColors = [
      "#FF5733",
      "#33FF57",
      "#5733FF",
      "#FF3366",
      "#33FFFF",
      "#FF33CC",
      "#CC33FF",
      "#FFFF33",
      "#33FFC7",
      "#FF33A6",
      "#33A6FF",
      "#A6FF33",
      "#FFC733",
      "#C733FF",
      "#33FF33",
      "#FF3333",
      "#3333FF",
      "#FF9933",
      "#33FF99",
      "#9933FF",
      "#FF3399",
      "#3399FF",
      "#FF6633",
      "#33FF66",
    ];
    return Color(
        int.parse(skillColors[value.index].substring(1, 7), radix: 16) +
            0xFF000000);
  }
}
