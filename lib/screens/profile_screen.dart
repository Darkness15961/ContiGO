import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/mock_repository.dart';
import '../theme/app_theme.dart';
import '../widgets/person_avatar.dart';
import '../widgets/tag_wrap.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.repo});

  final MockRepository repo;

  @override
  Widget build(BuildContext context) {
    final user = repo.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil', style: displayStyle(size: 26)),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          Row(
            children: [
              PersonAvatar(
                name: user.name,
                initials: user.initials,
                size: 64,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: GoogleFonts.dmSans(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '${user.career} · ${user.year}',
                      style: GoogleFonts.dmSans(
                        fontSize: 13,
                        color: AppColors.muted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          Text('¿Qué te mueve?', style: displayStyle(size: 24)),
          const SizedBox(height: 10),
          Text(
            user.whatMovesYou,
            style: GoogleFonts.dmSans(
              fontSize: 15,
              height: 1.55,
              color: AppColors.inkSoft,
            ),
          ),
          const SizedBox(height: 24),
          const SectionLabel('INTERESES'),
          const SizedBox(height: 8),
          TagWrap(tags: user.interests),
          const SizedBox(height: 20),
          const SectionLabel('FORMA DE TRABAJAR'),
          const SizedBox(height: 8),
          Text(
            user.workStyle,
            style: GoogleFonts.dmSans(fontSize: 15),
          ),
          const SizedBox(height: 4),
          Text(
            user.availability,
            style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.muted),
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionLabel('PUEDO ENSEÑAR'),
                    const SizedBox(height: 8),
                    TagWrap(tags: user.canTeach),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionLabel('QUIERO APRENDER'),
                    const SizedBox(height: 8),
                    TagWrap(tags: user.wantsToLearn, ember: true),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFE8F3F1), Color(0xFFF6EFE8)],
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ContiGO', style: displayStyle(size: 20)),
                const SizedBox(height: 6),
                Text(
                  'No buscamos personas perfectas.\nBuscamos personas que quieran construir juntas.\n\nLo demás se aprende.',
                  style: GoogleFonts.dmSans(
                    fontSize: 14,
                    height: 1.45,
                    color: AppColors.inkSoft,
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
