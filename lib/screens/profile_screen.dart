import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/mock_repository.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import 'create_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    required this.repo,
    required this.onChanged,
  });

  final MockRepository repo;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    final u = repo.currentUser;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
          children: [
            Center(
              child: Column(
                children: [
                  PersonAvatar(name: u.name, initials: u.initials, size: 88),
                  const SizedBox(height: 12),
                  Text(
                    u.name,
                    style: displayStyle(size: 26),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    u.career,
                    style: GoogleFonts.dmSans(
                      fontSize: 14,
                      color: AppColors.grayDark,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
            Text('¿Qué me mueve?', style: displayStyle(size: 22)),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.violetSoft,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                '"${u.whatMovesYou}"',
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  height: 1.5,
                  color: AppColors.violetDeep,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),
            const SectionLabel('HABILIDADES'),
            const SizedBox(height: 8),
            TagWrap(tags: u.skills),
            const SizedBox(height: 16),
            const SectionLabel('INTERESES'),
            const SizedBox(height: 8),
            TagWrap(tags: u.interests),
            const SizedBox(height: 16),
            const SectionLabel('QUIERO APRENDER'),
            const SizedBox(height: 8),
            TagWrap(tags: u.wantsToLearn, filled: false),
            const SizedBox(height: 16),
            Text(
              '${u.availability} · ${u.modality.label}',
              style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.grayDark),
            ),
            const SizedBox(height: 28),
            OutlinedButton(
              onPressed: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => CreateProfileScreen(repo: repo),
                  ),
                );
                onChanged();
              },
              child: const Text('Editar perfil'),
            ),
          ],
        ),
      ),
    );
  }
}
