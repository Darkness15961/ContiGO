import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/models.dart';
import '../theme/app_theme.dart';
import 'person_avatar.dart';
import 'tag_wrap.dart';

class IdeaCard extends StatelessWidget {
  const IdeaCard({
    super.key,
    required this.idea,
    required this.onTap,
    this.connected = false,
    this.isMine = false,
  });

  final ProjectIdea idea;
  final VoidCallback onTap;
  final bool connected;
  final bool isMine;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.paper,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.line),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  PersonAvatar(name: idea.author.name, initials: idea.author.initials),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          idea.author.name,
                          style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          '${idea.author.career} · ${idea.author.year}',
                          style: GoogleFonts.dmSans(
                            fontSize: 12,
                            color: AppColors.muted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (connected)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.emberSoft,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Conectaste',
                        style: GoogleFonts.dmSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppColors.ember,
                        ),
                      ),
                    )
                  else if (isMine)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.tealSoft,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Tu idea',
                        style: GoogleFonts.dmSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppColors.teal,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                '¿Qué le mueve?',
                style: GoogleFonts.dmSans(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppColors.muted,
                  letterSpacing: 0.4,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                idea.author.whatMovesYou,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.dmSans(
                  fontSize: 13,
                  height: 1.45,
                  color: AppColors.inkSoft,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                idea.title,
                style: displayStyle(size: 20),
              ),
              const SizedBox(height: 10),
              Text(
                idea.why,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  height: 1.45,
                  color: AppColors.inkSoft,
                ),
              ),
              const SizedBox(height: 14),
              TagWrap(tags: [...idea.motivationTags, ...idea.themeTags.take(2)]),
            ],
          ),
        ),
      ),
    );
  }
}
