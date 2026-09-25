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
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: ContigoHeroHeader(
              height: 200,
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'ContiGO',
                            style: GoogleFonts.fraunces(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: AppColors.white,
                            ),
                          ),
                          const Spacer(),
                          Icon(Icons.notifications_none, color: AppColors.white.withValues(alpha: 0.9)),
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Profile card overlapping header
          SliverToBoxAdapter(
            child: Transform.translate(
              offset: const Offset(0, -48),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SoftCard(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      PersonAvatar(
                        name: user.name,
                        initials: user.initials,
                        size: 54,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hola, $firstName 👋',
                              style: GoogleFonts.dmSans(
                                fontWeight: FontWeight.w800,
                                fontSize: 17,
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
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF22C55E),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Listo para conectar',
                                  style: GoogleFonts.dmSans(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF16A34A),
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
            ),
          ),
          SliverToBoxAdapter(
            child: Transform.translate(
              offset: const Offset(0, -28),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '¿Con qué idea quieres conectar hoy?',
                      style: GoogleFonts.dmSans(
                        fontSize: 15,
                        color: AppColors.grayDark,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: SoftCard(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Ideas',
                                  style: GoogleFonts.dmSans(
                                    fontSize: 12,
                                    color: AppColors.grayDark,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '$ideaCount',
                                  style: displayStyle(
                                    size: 26,
                                    color: AppColors.violetDeep,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: LinearProgressIndicator(
                                    value: 0.72,
                                    minHeight: 6,
                                    backgroundColor: AppColors.violetSoft,
                                    color: AppColors.violet,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: SoftCard(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Matches',
                                  style: GoogleFonts.dmSans(
                                    fontSize: 12,
                                    color: AppColors.grayDark,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '$matchCount',
                                  style: displayStyle(
                                    size: 26,
                                    color: AppColors.violetDeep,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: LinearProgressIndicator(
                                    value: matchCount / 5,
                                    minHeight: 6,
                                    backgroundColor: AppColors.violetSoft,
                                    color: AppColors.violetMid,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text('Proyectos para ti', style: displayStyle(size: 22)),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
            sliver: SliverList.separated(
              itemCount: projects.length,
              separatorBuilder: (_, __) => const SizedBox(height: 14),
              itemBuilder: (context, index) {
                final p = projects[index];
                return ProjectCard(
                  project: p,
                  interested: repo.interestedProjectIds.contains(p.id),
                  accentColor: index.isEven
                      ? AppColors.violet
                      : AppColors.violetMid,
                  onTap: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) =>
                            ProjectDetailScreen(repo: repo, project: p),
                      ),
                    );
                    onChanged();
                  },
                  onInterest: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ProjectDetailScreen(
                          repo: repo,
                          project: p,
                          openInterest: true,
                        ),
                      ),
                    );
                    onChanged();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
