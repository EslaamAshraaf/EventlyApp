import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChipItem extends StatelessWidget {
  final Function() onTap;
  final bool isSelected;
  final String title;
  final Color borderColor;
  final Color bg;
  final Color textColor;

  const ChipItem({
    super.key,
    required this.onTap,
    required this.title,
    required this.isSelected,
    required this.borderColor,
    required this.bg,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(37),
          border: Border.all(color: borderColor),
          color: bg,
        ),
        child: Text(
          title,
          style: TextStyle(
            color: textColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}