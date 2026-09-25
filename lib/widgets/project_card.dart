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
      accentBar: accentColor ?? AppColors.primary,
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ProjectCover(project: project, height: 120, borderRadius: 14),
          const SizedBox(height: 12),
          Row(
            children: [
              PersonAvatar.fromStudent(project.author, size: 28),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  project.author.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.dmSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.grayDark,
                  ),
                ),
              ),
              if (interested)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.cream,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Te interesa',
                    style: GoogleFonts.dmSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            project.codeName,
            style: GoogleFonts.dmSans(
              fontWeight: FontWeight.w800,
              fontSize: 12,
              color: AppColors.primary,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            project.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: displayStyle(size: 16),
          ),
          const SizedBox(height: 8),
          TagWrap(tags: project.categories),
          const SizedBox(height: 8),
          Text(
            '"${project.lookingForPeople}"',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.dmSans(
              fontSize: 12,
              height: 1.4,
              fontStyle: FontStyle.italic,
              color: AppColors.grayDark,
            ),
          ),
          if (showInterestButton && onInterest != null && !interested) ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                onPressed: onInterest,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(44),
                ),
                child: const Text('Me interesa'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
