import 'package:flutter/material.dart';

extension ColorToMaterialColor on Color {
  static List<int> palettes = [50, 100, 200, 300, 400, 500, 600, 700, 800, 900];
  MaterialColor toMaterialByOpacity() {
    Map<int, Color> colors = palettes.asMap().map((index, palette) =>
        MapEntry(palette, this.withOpacity((index + 1) / 10)));
    return MaterialColor(this.value, colors);
  }
}
