import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/models.dart';
import '../theme/app_theme.dart';
import 'common.dart';
import 'visual.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({
    super.key,
    required this.project,
    required this.onTap,
    this.onInterest,
    this.interested = false,
    this.showInterestButton = true,
    this.accentColor,
  });

  final ProjectIdea project;
  final VoidCallback onTap;
  final VoidCallback? onInterest;
  final bool interested;
  final bool showInterestButton;
  final Color? accentColor;

  @override
  Widget build(BuildContext context) {
    return SoftCard(
      onTap: onTap,
      accentBar: accentColor ?? AppColors.violet,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('💡', style: TextStyle(fontSize: 18)),
              const SizedBox(width: 8),
              Text(
                project.codeName,
                style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                  color: AppColors.violetDeep,
                  letterSpacing: 0.6,
                ),
              ),
              const Spacer(),
              if (interested)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.violetSoft,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Te interesa',
                    style: GoogleFonts.dmSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.violet,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Text(project.title, style: displayStyle(size: 19)),
          const SizedBox(height: 10),
          TagWrap(tags: project.categories),
          const SizedBox(height: 12),
          Text(
            '"${project.lookingForPeople}"',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.dmSans(
              fontSize: 13,
              height: 1.45,
              fontStyle: FontStyle.italic,
              color: AppColors.grayDark,
            ),
          ),
          if (showInterestButton && onInterest != null && !interested) ...[
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onInterest,
                child: const Text('Me interesa'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
