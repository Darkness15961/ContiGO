import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/mock_repository.dart';
import '../theme/app_theme.dart';
import '../widgets/project_card.dart';
import 'project_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.repo, required this.onChanged});

  final MockRepository repo;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    final firstName = repo.currentUser.name.split(' ').first;
    final projects = repo.recommended();

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
          children: [
            Text(
              'Hola, $firstName 👋',
              style: displayStyle(size: 28),
            ),
            const SizedBox(height: 6),
            Text(
              '¿Con qué idea quieres conectar hoy?',
              style: GoogleFonts.dmSans(
                fontSize: 16,
                color: AppColors.grayDark,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 28),
            Text('Proyectos para ti', style: displayStyle(size: 22)),
            const SizedBox(height: 14),
            for (final p in projects) ...[
              ProjectCard(
                project: p,
                interested: repo.interestedProjectIds.contains(p.id),
                onTap: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ProjectDetailScreen(repo: repo, project: p),
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
              ),
              const SizedBox(height: 14),
            ],
          ],
        ),
      ),
    );
  }
}
