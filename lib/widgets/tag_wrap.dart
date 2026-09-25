import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_theme.dart';

class TagWrap extends StatelessWidget {
  const TagWrap({
    super.key,
    required this.tags,
    this.ember = false,
  });

  final List<String> tags;
  final bool ember;

  @override
  Widget build(BuildContext context) {
    if (tags.isEmpty) return const SizedBox.shrink();
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final tag in tags)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: ember ? AppColors.emberSoft : AppColors.tealSoft,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              tag,
              style: GoogleFonts.dmSans(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: ember ? AppColors.ember : AppColors.teal,
              ),
            ),
          ),
      ],
    );
  }
}
