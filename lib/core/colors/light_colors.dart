import 'dart:ui';
import 'package:evently/core/colors/main_colors.dart';

class LightColors implements MainColors {
  @override
  Color get primary100 => const Color(0xFFE8ECFF);

  @override
  Color get primary200 => const Color(0xFFC3CBFF);

  @override
  Color get primary300 => const Color(0xFF9FAAFF);

  @override
  Color get primary400 => const Color(0xFF7A89FF);

  @override
  Color get primary500 => const Color(0xFF5669FF);

  @override
  Color get primary600 => const Color(0xFF4054DB);

  @override
  Color get secondary => const Color(0xFFF2FEFF);

  @override
  Color get warning => const Color(0xFFFFF4D8);

  @override
  Color get error => const Color(0xFFEF5350);

  @override
  Color get error200 => const Color(0xFFFFCDD2);
}
