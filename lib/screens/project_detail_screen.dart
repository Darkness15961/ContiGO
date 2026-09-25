import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/mock_repository.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import 'interest_screen.dart';
import 'match_screen.dart';

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
      widget.repo.interestedProjectIds.contains(widget.project.id);

  Future<void> _openInterest() async {
    if (_isMine || _interested) return;
    final note = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder: (_) => InterestScreen(project: widget.project),
        fullscreenDialog: true,
      ),
    );
    if (note == null || note.isEmpty) return;
    widget.repo.expressInterest(widget.project.id, note);
    if (!mounted) return;
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MatchScreen(
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
          const SectionLabel('💡 TÍTULO'),
          const SizedBox(height: 8),
          Text(p.codeName, style: brandStyle(size: 18)),
          const SizedBox(height: 6),
          Text(p.title, style: displayStyle(size: 26)),
          const SizedBox(height: 24),
          const SectionLabel('SOBRE LA IDEA'),
          const SizedBox(height: 8),
          Text(p.about, style: GoogleFonts.dmSans(fontSize: 15, height: 1.55)),
          const SizedBox(height: 24),
          const SectionLabel('¿POR QUÉ QUIERO HACERLO?'),
          const SizedBox(height: 8),
          Text(p.why, style: GoogleFonts.dmSans(fontSize: 15, height: 1.55)),
          const SizedBox(height: 8),
          Text(
            p.motivation,
            style: GoogleFonts.dmSans(
              fontSize: 14,
              height: 1.5,
              fontStyle: FontStyle.italic,
              color: AppColors.grayDark,
            ),
          ),
          const SizedBox(height: 28),
          const SectionLabel('👤 CONOCE AL CREADOR'),
          const SizedBox(height: 12),
          Row(
            children: [
              PersonAvatar(name: a.name, initials: a.initials, size: 52),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      a.name,
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      a.career,
                      style: GoogleFonts.dmSans(
                        fontSize: 13,
                        color: AppColors.grayDark,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text('¿Qué me mueve?', style: displayStyle(size: 20)),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.violetSoft,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              a.whatMovesYou,
              style: GoogleFonts.dmSans(
                fontSize: 14,
                height: 1.5,
                color: AppColors.violetDeep,
              ),
            ),
          ),
          const SizedBox(height: 28),
          const SectionLabel('ESTOY BUSCANDO'),
          const SizedBox(height: 8),
          TagWrap(tags: p.knowledgeAreas),
          const SizedBox(height: 20),
          const SectionLabel('¿QUÉ BUSCO EN LAS PERSONAS?'),
          const SizedBox(height: 8),
          Text(
            p.lookingForPeople,
            style: GoogleFonts.dmSans(fontSize: 15, height: 1.55),
          ),
          const SizedBox(height: 20),
          const SectionLabel('MODALIDAD'),
          const SizedBox(height: 8),
          Text(
            p.modality.label,
            style: GoogleFonts.dmSans(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.bgSoft,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              'No buscamos personas perfectas. Buscamos personas que conecten con una idea. Lo demás se aprende.',
              style: GoogleFonts.dmSans(
                fontSize: 14,
                height: 1.45,
                color: AppColors.grayDark,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _isMine
          ? null
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                child: ElevatedButton.icon(
                  onPressed: _interested ? null : _openInterest,
                  icon: Icon(_interested ? Icons.favorite : Icons.favorite_border),
                  label: Text(_interested ? 'Ya enviaste interés' : 'Me interesa'),
                ),
              ),
            ),
    );
  }
}
