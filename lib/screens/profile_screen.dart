import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/mock_repository.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import 'create_profile_screen.dart';
import 'login_screen.dart';
import 'project_detail_screen.dart';

/// Perfil estilo Instagram: avatar + stats + bio + grid de ideas.
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
    final mine = repo.myProjects();
    final matches = repo.myConnections().length;
    final pending = repo.pendingForCreator;
    final topInset = MediaQuery.paddingOf(context).top;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, topInset + 8, 16, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      u.name.split(' ').first.toLowerCase(),
                      style: GoogleFonts.dmSans(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: AppColors.deep,
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: 'Editar perfil',
                    onPressed: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => CreateProfileScreen(repo: repo),
                        ),
                      );
                      onChanged();
                    },
                    icon: const Icon(Icons.edit_outlined, color: AppColors.deep),
                  ),
                  IconButton(
                    tooltip: 'Cerrar sesión',
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                        (_) => false,
                      );
                    },
                    icon: const Icon(Icons.logout, color: AppColors.grayDark),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(2.5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primary, width: 2),
                    ),
                    child: PersonAvatar.fromStudent(u, size: 86),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _Stat(value: '${mine.length}', label: 'ideas'),
                        _Stat(value: '$matches', label: 'match'),
                        _Stat(
                          value: '$pending',
                          label: 'pendientes',
                          highlight: pending > 0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    u.name,
                    style: GoogleFonts.dmSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: AppColors.deep,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    u.career,
                    style: GoogleFonts.dmSans(
                      fontSize: 13,
                      color: AppColors.grayDark,
                    ),
                  ),
                  const SizedBox(height: 10),
                  MetaBadgeRow(province: u.province, modality: u.modality),
                  if (u.whatMovesYou.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Text(
                      u.whatMovesYou,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.dmSans(
                        fontSize: 13,
                        height: 1.45,
                        color: AppColors.deep,
                      ),
                    ),
                  ],
                  if (u.interests.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    TagWrap(tags: u.interests, asHashtags: true),
                  ],
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () async {
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => CreateProfileScreen(repo: repo),
                              ),
                            );
                            onChanged();
                          },
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size.fromHeight(40),
                            padding: EdgeInsets.zero,
                          ),
                          child: const Text('Editar perfil'),
                        ),
                      ),
                    ],
                  ),
                  if (u.skills.isNotEmpty || u.wantsToLearn.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    if (u.skills.isNotEmpty) ...[
                      Text(
                        'Habilidades',
                        style: GoogleFonts.dmSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.grayDark,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TagWrap(tags: u.skills),
                    ],
                    if (u.wantsToLearn.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Text(
                        'Quiero aprender',
                        style: GoogleFonts.dmSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.grayDark,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TagWrap(tags: u.wantsToLearn),
                    ],
                  ],
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(Icons.grid_on, size: 18, color: AppColors.primary),
                      const SizedBox(width: 8),
                      Text(
                        'Mis ideas',
                        style: GoogleFonts.dmSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: AppColors.deep,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
          if (mine.isEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 40),
                child: Text(
                  'Aún no publicaste ideas. Usa ＋ Crear.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dmSans(color: AppColors.grayDark),
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(2, 0, 2, 28),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, i) {
                    final p = mine[i];
                    return InkWell(
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
                      child: _IdeaTile(project: p),
                    );
                  },
                  childCount: mine.length,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _IdeaTile extends StatelessWidget {
  const _IdeaTile({required this.project});

  final ProjectIdea project;

  @override
  Widget build(BuildContext context) {
    ImageProvider? image;
    final url = project.coverUrl;
    if (url != null && url.isNotEmpty) {
      image = NetworkImage(url);
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        const ColoredBox(color: AppColors.cream),
        if (image != null)
          Image(
            image: image,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) =>
                const ColoredBox(color: AppColors.cream),
          ),
        Positioned(
          left: 6,
          right: 6,
          bottom: 6,
          child: Text(
            project.codeName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.dmSans(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: AppColors.white,
              shadows: const [
                Shadow(blurRadius: 6, color: Colors.black54),
              ],
            ),
          ),
        ),
        if (!project.isPublished)
          const Positioned(
            top: 6,
            right: 6,
            child: Icon(
              Icons.pause_circle_filled,
              size: 18,
              color: AppColors.orange,
            ),
          ),
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({
    required this.value,
    required this.label,
    this.highlight = false,
  });

  final String value;
  final String label;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.dmSans(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: highlight ? AppColors.orange : AppColors.deep,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.dmSans(
            fontSize: 11,
            color: AppColors.grayDark,
          ),
        ),
      ],
    );
  }
}
