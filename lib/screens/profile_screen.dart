import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/mock_repository.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import '../widgets/visual.dart';
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
      backgroundColor: AppColors.bgSoft,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 260,
              child: BlotchBackground(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36),
                ),
                child: SafeArea(
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        'Perfil',
                        style: GoogleFonts.fraunces(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.circle,
                        ),
                        child: PersonAvatar(
                          name: u.name,
                          initials: u.initials,
                          size: 88,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        u.name,
                        style: GoogleFonts.dmSans(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: AppColors.white,
                        ),
                      ),
                      Text(
                        u.career,
                        style: GoogleFonts.dmSans(
                          fontSize: 13,
                          color: AppColors.white.withValues(alpha: 0.85),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                SoftCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('¿Qué me mueve?', style: displayStyle(size: 20)),
                      const SizedBox(height: 10),
                      Text(
                        '"${u.whatMovesYou}"',
                        style: GoogleFonts.dmSans(
                          fontSize: 14,
                          height: 1.5,
                          color: AppColors.violetDeep,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                SoftCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SectionLabel('DATOS'),
                      const SizedBox(height: 12),
                      _InfoRow('Correo', u.email),
                      _InfoRow('Disponibilidad', u.availability),
                      _InfoRow('Modalidad', u.modality.label),
                      _InfoRow('Pasiones', u.passions),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                SoftCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                SoftCard(
                  onTap: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => CreateProfileScreen(repo: repo),
                      ),
                    );
                    onChanged();
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.edit_outlined, color: AppColors.violet),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Editar perfil',
                          style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const Icon(Icons.chevron_right, color: AppColors.grayDark),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: GoogleFonts.dmSans(
                fontSize: 13,
                color: AppColors.grayDark,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.dmSans(fontSize: 13, height: 1.35),
            ),
          ),
        ],
      ),
    );
  }
}
