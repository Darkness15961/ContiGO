import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/mock_repository.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import '../widgets/project_card.dart';
import '../widgets/visual.dart';
import 'project_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.repo, required this.onChanged});

  final MockRepository repo;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    final user = repo.currentUser;
    final firstName = user.name.split(' ').first;
    final projects = repo.recommended();
    final matchCount = repo.connections.length;
    final ideaCount = repo.projects.length;

    return Scaffold(
      backgroundColor: AppColors.bgSoft,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          OverlapHeader(
            toolbar: Row(
              children: [
                Text(
                  'ContiGO',
                  style: GoogleFonts.dmSans(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: AppColors.white,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.notifications_none_rounded,
                  color: AppColors.white.withValues(alpha: 0.95),
                ),
              ],
            ),
            overlapChild: SoftCard(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Row(
                children: [
                  PersonAvatar(
                    name: user.name,
                    initials: user.initials,
                    size: 50,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Hola, $firstName',
                          style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          user.career,
                          style: GoogleFonts.dmSans(
                            fontSize: 12,
                            color: AppColors.grayDark,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              width: 7,
                              height: 7,
                              decoration: const BoxDecoration(
                                color: AppColors.success,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Listo para conectar',
                              style: GoogleFonts.dmSans(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: AppColors.success,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '¿Con qué idea quieres conectar hoy?',
                  style: GoogleFonts.dmSans(
                    fontSize: 14,
                    color: AppColors.grayDark,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: SoftCard(
                        padding: const EdgeInsets.all(14),
                        child: _StatBlock(
                          label: 'Ideas',
                          value: '$ideaCount',
                          progress: 0.7,
                          color: AppColors.violet,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: SoftCard(
                        padding: const EdgeInsets.all(14),
                        child: _StatBlock(
                          label: 'Match',
                          value: '$matchCount',
                          progress: (matchCount / 5).clamp(0.15, 1),
                          color: AppColors.accentPink,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                Text('Proyectos para ti', style: displayStyle(size: 20)),
                const SizedBox(height: 12),
                for (var i = 0; i < projects.length; i++) ...[
                  ProjectCard(
                    project: projects[i],
                    interested:
                        repo.interestedProjectIds.contains(projects[i].id),
                    accentColor:
                        i.isEven ? AppColors.violet : AppColors.accentPink,
                    onTap: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ProjectDetailScreen(
                            repo: repo,
                            project: projects[i],
                          ),
                        ),
                      );
                      onChanged();
                    },
                    onInterest: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ProjectDetailScreen(
                            repo: repo,
                            project: projects[i],
                            openInterest: true,
                          ),
                        ),
                      );
                      onChanged();
                    },
                  ),
                  const SizedBox(height: 12),
                ],
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatBlock extends StatelessWidget {
  const _StatBlock({
    required this.label,
    required this.value,
    required this.progress,
    required this.color,
  });

  final String label;
  final String value;
  final double progress;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: GoogleFonts.dmSans(fontSize: 12, color: AppColors.grayDark),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: displayStyle(size: 24, color: AppColors.violetDeep),
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 5,
            backgroundColor: AppColors.violetSoft,
            color: color,
          ),
        ),
      ],
    );
  }
}
