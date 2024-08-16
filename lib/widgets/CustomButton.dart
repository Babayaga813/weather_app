import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final Color buttonColor;
  final VoidCallback onTap;
  final String label;
  final IconData icon;

  const CustomButton({
    super.key,
    required this.buttonColor,
    required this.onTap,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final splashColor = buttonColor.withOpacity(0.3);
    final backgroundColor = buttonColor.withAlpha(50);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: backgroundColor,
      ),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: backgroundColor,
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          splashColor: splashColor,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 12).r,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 20,
                ),
                12.horizontalSpace,
                Text(
                  label,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
