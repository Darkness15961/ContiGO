import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/mock_repository.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import '../widgets/visual.dart';
import 'manage_team_screen.dart';
import 'project_detail_screen.dart';

/// Inicio = hub personal. El catálogo vive solo en Explorar.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.repo, required this.onChanged});

  final MockRepository repo;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    final user = repo.currentUser;
    final firstName = user.name.split(' ').first;
    final mine = repo.myProjects();
    final pending = mine.fold<int>(0, (n, p) => n + p.pendingRequests.length);
    final matches = repo.myConnections().length;

    return Scaffold(
      backgroundColor: AppColors.bgSoft,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          OverlapHeader(
            toolbar: Text(
              'ContiGO',
              style: GoogleFonts.dmSans(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: AppColors.white,
              ),
            ),
            overlapChild: SoftCard(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Row(
                children: [
                  PersonAvatar.fromStudent(user, size: 50),
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tu espacio. Las ideas nuevas están en Explorar.',
                  style: GoogleFonts.dmSans(
                    fontSize: 14,
                    color: AppColors.grayDark,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: SoftCard(
                        padding: const EdgeInsets.all(14),
                        child: _MiniStat(
                          label: 'Mis ideas',
                          value: '${mine.length}',
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: SoftCard(
                        padding: const EdgeInsets.all(14),
                        child: _MiniStat(
                          label: 'Match',
                          value: '$matches',
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: SoftCard(
                        padding: const EdgeInsets.all(14),
                        child: _MiniStat(
                          label: 'Pendientes',
                          value: '$pending',
                          highlight: pending > 0,
                        ),
                      ),
                    ),
                  ],
                ),
                if (pending > 0) ...[
                  const SizedBox(height: 20),
                  Text('Solicitudes por revisar', style: displayStyle(size: 18)),
                  const SizedBox(height: 8),
                  SoftCard(
                    onTap: () async {
                      final withPending = mine.firstWhere(
                        (p) => p.pendingRequests.isNotEmpty,
                      );
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ManageTeamScreen(
                            repo: repo,
                            project: withPending,
                          ),
                        ),
                      );
                      onChanged();
                    },
                    child: Row(
                      children: [
                        Icon(Icons.handshake_outlined, color: AppColors.primary),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            '$pending persona(s) esperan que registres el match',
                            style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const Icon(Icons.chevron_right, color: AppColors.grayDark),
                      ],
                    ),
                  ),
                ],
                if (mine.isNotEmpty) ...[
                  const SizedBox(height: 22),
                  Text('Mis proyectos', style: displayStyle(size: 18)),
                  const SizedBox(height: 10),
                  for (final p in mine)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: SoftCard(
                        onTap: () async {
                          await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ProjectDetailScreen(
                                repo: repo,
                                project: p,
                              ),
                            ),
                          );
                          onChanged();
                        },
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    p.codeName,
                                    style: GoogleFonts.dmSans(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 13,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    p.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.dmSans(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${p.province.label} · ${p.modality.label} · '
                                    '${p.memberCount}/${p.targetMembers} · '
                                    '${p.isPublished ? 'Publicado' : 'Pausado'}'
                                    '${p.pendingRequests.isEmpty ? '' : ' · ${p.pendingRequests.length} solicitudes'}',
                                    style: GoogleFonts.dmSans(
                                      fontSize: 12,
                                      color: AppColors.grayDark,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.chevron_right,
                              color: AppColors.grayDark,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
                const SizedBox(height: 22),
                SoftCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '¿Buscas una idea?',
                        style: displayStyle(size: 17),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Explorar es el catálogo: busca por #emprendimiento, #social y más.',
                        style: GoogleFonts.dmSans(
                          fontSize: 13,
                          color: AppColors.grayDark,
                          height: 1.4,
                        ),
                      ),
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

class _MiniStat extends StatelessWidget {
  const _MiniStat({
    required this.label,
    required this.value,
    this.highlight = false,
  });

  final String label;
  final String value;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.dmSans(fontSize: 11, color: AppColors.grayDark),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: displayStyle(
            size: 22,
            color: highlight ? AppColors.orange : AppColors.deep,
          ),
        ),
      ],
    );
  }
}
