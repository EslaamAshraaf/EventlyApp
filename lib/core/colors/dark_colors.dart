import 'dart:ui';
import 'package:evently/core/colors/main_colors.dart';

class DarkColors implements MainColors {
  @override
  Color get primary100 => const Color(0xFF101127);

  @override
  Color get primary200 => const Color(0xFF1A1B35);

  @override
  Color get primary300 => const Color(0xFF2C2D45);

  @override
  Color get primary400 => const Color(0xFF3D3E57);

  @override
  Color get primary500 => const Color(0xFF4E4F6A);

  @override
  Color get primary600 => const Color(0xFF5F6080);

  @override
  Color get secondary => const Color(0xFF18192B);

  @override
  Color get warning => const Color(0xFFFFE082);

  @override
  Color get error => const Color(0xFFEF5350);

  @override
  Color get error200 => const Color(0xFFFFCDD2);
}
