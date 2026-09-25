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
    final topInset = MediaQuery.paddingOf(context).top;

    return Scaffold(
      backgroundColor: AppColors.bgSoft,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Header completo sin Transform: nada tapa nombre/avatar
          ClipPath(
            clipper: WaveClipper(),
            child: BlotchBackground(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, topInset + 8, 20, 40),
                child: Column(
                  children: [
                    Text(
                      'Perfil',
                      style: GoogleFonts.dmSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.white, width: 3),
                      ),
                      child:                       PersonAvatar.fromStudent(u, size: 84),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      u.name,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.dmSans(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      u.career,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.dmSans(
                        fontSize: 13,
                        color: AppColors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
            child: Column(
              children: [
                SoftCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('¿Qué me mueve?', style: displayStyle(size: 17)),
                      const SizedBox(height: 10),
                      Text(
                        u.whatMovesYou,
                        style: GoogleFonts.dmSans(
                          fontSize: 13,
                          height: 1.5,
                          color: AppColors.grayDark,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                SoftCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Datos', style: displayStyle(size: 16)),
                      const SizedBox(height: 12),
                      _DataLine('Correo', u.email),
                      _DataLine('Disponibilidad', u.availability),
                      _DataLine('Modalidad', u.modality.label),
                      _DataLine('Pasiones', u.passions),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                SoftCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Habilidades', style: displayStyle(size: 16)),
                      const SizedBox(height: 8),
                      TagWrap(tags: u.skills),
                      const SizedBox(height: 14),
                      Text('Intereses', style: displayStyle(size: 16)),
                      const SizedBox(height: 8),
                      TagWrap(tags: u.interests),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
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
                      Text(
                        'Editar perfil',
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.chevron_right, color: AppColors.grayDark),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DataLine extends StatelessWidget {
  const _DataLine(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.dmSans(
              fontSize: 12,
              color: AppColors.grayDark,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: GoogleFonts.dmSans(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
}
