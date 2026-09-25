import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/models.dart';
import '../theme/app_theme.dart';
import 'common.dart';
import 'visual.dart';

/// Card de publicación: cover + autor + idea + meta (teal) + # + CTA.
class ProjectCard extends StatelessWidget {
  const ProjectCard({
    super.key,
    required this.project,
    required this.onTap,
    this.onInterest,
    this.interested = false,
    this.showInterestButton = true,
  });

  final ProjectIdea project;
  final VoidCallback onTap;
  final VoidCallback? onInterest;
  final bool interested;
  final bool showInterestButton;

  @override
  Widget build(BuildContext context) {
    return SoftCard(
      onTap: onTap,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: ProjectCover(
              project: project,
              height: 148,
              borderRadius: 0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    PersonAvatar.fromStudent(project.author, size: 28),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            project.author.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.dmSans(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppColors.deep,
                            ),
                          ),
                          Text(
                            project.author.career,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.dmSans(
                              fontSize: 11,
                              color: AppColors.grayDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.groups_outlined,
                      size: 16,
                      color: AppColors.grayDark,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${project.memberCount}/${project.targetMembers}',
                      style: GoogleFonts.dmSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.deep,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      project.codeName,
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                        color: AppColors.primary,
                        letterSpacing: 0.6,
                      ),
                    ),
                    if (!project.isPublished) ...[
                      const SizedBox(width: 8),
                      Text(
                        'PAUSADO',
                        style: GoogleFonts.dmSans(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: AppColors.orange,
                        ),
                      ),
                    ],
                    if (interested) ...[
                      const Spacer(),
                      Text(
                        'Te interesa',
                        style: GoogleFonts.dmSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  project.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: displayStyle(size: 16),
                ),
                const SizedBox(height: 10),
                MetaBadgeRow(
                  province: project.province,
                  modality: project.modality,
                ),
                const SizedBox(height: 10),
                TagWrap(tags: project.hashtags, asHashtags: true),
                const SizedBox(height: 10),
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
                if (showInterestButton &&
                    onInterest != null &&
                    !interested) ...[
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
          ),
        ],
      ),
    );
  }
}
