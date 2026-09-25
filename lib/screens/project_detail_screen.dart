import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/mock_repository.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import 'interest_screen.dart';
import 'manage_team_screen.dart';

/// Detalle mínimo: idea + creador + CTA. Sin bloques repetidos.
class ProjectDetailScreen extends StatefulWidget {
  const ProjectDetailScreen({
    super.key,
    required this.repo,
    required this.project,
    this.openInterest = false,
  });

  final MockRepository repo;
  final ProjectIdea project;
  final bool openInterest;

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.openInterest) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _openInterest());
    }
  }

  bool get _isMine => widget.project.author.id == widget.repo.currentUser.id;
  bool get _interested =>
      widget.repo.interestedProjectIds.contains(widget.project.id) ||
      widget.project.pendingRequests
          .any((r) => r.from.id == widget.repo.currentUser.id);

  Future<void> _openInterest() async {
    if (_isMine || _interested) return;
    if (!widget.project.isPublished) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Este proyecto ya no busca personas (pausado).',
            style: GoogleFonts.dmSans(),
          ),
          backgroundColor: AppColors.orange,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    final note = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder: (_) => InterestScreen(project: widget.project),
        fullscreenDialog: true,
      ),
    );
    if (note == null || note.isEmpty) return;
    widget.repo.expressInterest(widget.project.id, note);
    if (!mounted) return;
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Solicitud enviada. El creador registrará el match si hay conexión.',
          style: GoogleFonts.dmSans(),
        ),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _openManageTeam() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ManageTeamScreen(
          repo: widget.repo,
          project: widget.project,
        ),
      ),
    );
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.project;
    final a = p.author;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(p.codeName, style: displayStyle(size: 20)),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 120),
        children: [
          ProjectCover(project: p, height: 180, borderRadius: 18),
          const SizedBox(height: 16),
          Text(p.title, style: displayStyle(size: 24)),
          const SizedBox(height: 10),
          TagWrap(tags: p.hashtags, asHashtags: true),
          const SizedBox(height: 10),
          MetaBadgeRow(province: p.province, modality: p.modality),
          const SizedBox(height: 8),
          Text(
            '${p.memberCount}/${p.targetMembers} miembros'
            '${p.isPublished ? '' : ' · Pausado'}',
            style: GoogleFonts.dmSans(
              fontSize: 13,
              color: AppColors.grayDark,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            p.about,
            style: GoogleFonts.dmSans(fontSize: 15, height: 1.55),
          ),
          if (p.why.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              p.why,
              style: GoogleFonts.dmSans(
                fontSize: 14,
                height: 1.5,
                color: AppColors.grayDark,
              ),
            ),
          ],
          if (p.motivation.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              p.motivation,
              style: GoogleFonts.dmSans(
                fontSize: 14,
                height: 1.5,
                fontStyle: FontStyle.italic,
                color: AppColors.deep,
              ),
            ),
          ],
          if (p.knowledgeAreas.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(
              'Conocimientos que podrían aportar',
              style: GoogleFonts.dmSans(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.grayDark,
              ),
            ),
            const SizedBox(height: 8),
            TagWrap(tags: p.knowledgeAreas),
          ],
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PersonAvatar.fromStudent(a, size: 48),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      a.name,
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      a.career,
                      style: GoogleFonts.dmSans(
                        fontSize: 13,
                        color: AppColors.grayDark,
                      ),
                    ),
                    const SizedBox(height: 8),
                    MetaBadgeRow(province: a.province, modality: a.modality),
                    if (a.whatMovesYou.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        a.whatMovesYou,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.dmSans(
                          fontSize: 13,
                          height: 1.4,
                          color: AppColors.deep,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Busca: ${p.lookingForPeople}',
            style: GoogleFonts.dmSans(fontSize: 14, height: 1.45),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
          child: _isMine
              ? ElevatedButton.icon(
                  onPressed: _openManageTeam,
                  icon: const Icon(Icons.groups_outlined),
                  label: Text(
                    p.pendingRequests.isEmpty
                        ? 'Gestionar equipo'
                        : 'Gestionar equipo · ${p.pendingRequests.length}',
                  ),
                )
              : ElevatedButton.icon(
                  onPressed: (_interested || !p.isPublished) ? null : _openInterest,
                  icon: Icon(
                    _interested ? Icons.favorite : Icons.favorite_border,
                  ),
                  label: Text(
                    !p.isPublished
                        ? 'Ya no busca miembros'
                        : _interested
                            ? 'Solicitud enviada'
                            : 'Me interesa',
                  ),
                ),
        ),
      ),
    );
  }
}
