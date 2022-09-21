import 'package:flutter/material.dart';

import '../led_api_client.dart';


class ColorSection {
  List<int> color;
  int count;

  ColorSection(this.color, this.count);

    Map<String, dynamic> toJson() {
    return {
      "count": count,
      "color": color,
    };
  }
}

class Alternating extends Pattern {
  String get name => "alternating";

  final List<ColorSection> colors;

  Alternating(this.colors);

  Map<String, dynamic> getArgs() => {
       "colors": colors.map((element) => element.toJson()).toList()
  };
}
