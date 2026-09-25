import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/mock_repository.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/person_avatar.dart';
import '../widgets/tag_wrap.dart';

class IdeaDetailScreen extends StatefulWidget {
  const IdeaDetailScreen({
    super.key,
    required this.repo,
    required this.idea,
  });

  final MockRepository repo;
  final ProjectIdea idea;

  @override
  State<IdeaDetailScreen> createState() => _IdeaDetailScreenState();
}

class _IdeaDetailScreenState extends State<IdeaDetailScreen> {
  final Set<ConnectionReason> _selected = {};

  bool get _isMine => widget.idea.author.id == widget.repo.currentUser.id;
  bool get _connected =>
      widget.repo.connectedIdeaIds.contains(widget.idea.id);

  Future<void> _connect() async {
    if (_isMine) return;
    final reasons = await showModalBottomSheet<List<ConnectionReason>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.paper,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => _ConnectionSheet(
        initiallySelected: {
          ...?widget.repo.connectionReasons[widget.idea.id],
          ..._selected,
        },
      ),
    );
    if (reasons == null || reasons.isEmpty) return;
    setState(() {
      widget.repo.connectToIdea(widget.idea.id, reasons);
      _selected
        ..clear()
        ..addAll(reasons);
    });
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Señal enviada a ${widget.idea.author.name}. Match = interés mutuo.',
          style: GoogleFonts.dmSans(),
        ),
        backgroundColor: AppColors.teal,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final idea = widget.idea;
    final author = idea.author;

    return Scaffold(
      appBar: AppBar(
        title: Text('Idea', style: displayStyle(size: 22)),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 120),
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PersonAvatar(
                name: author.name,
                initials: author.initials,
                size: 56,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      author.name,
                      style: GoogleFonts.dmSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '${author.career} · ${author.year}',
                      style: GoogleFonts.dmSans(
                        fontSize: 13,
                        color: AppColors.muted,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${author.workStyle} · ${author.availability}',
                      style: GoogleFonts.dmSans(
                        fontSize: 12,
                        color: AppColors.inkSoft,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const SectionLabel('¿QUÉ LE MUEVE?'),
          const SizedBox(height: 8),
          Text(
            author.whatMovesYou,
            style: GoogleFonts.dmSans(
              fontSize: 15,
              height: 1.55,
              fontStyle: FontStyle.italic,
              color: AppColors.inkSoft,
            ),
          ),
          const SizedBox(height: 28),
          const SectionLabel('LA IDEA'),
          const SizedBox(height: 8),
          Text(idea.title, style: displayStyle(size: 26)),
          const SizedBox(height: 12),
          TagWrap(tags: idea.themeTags),
          const SizedBox(height: 28),
          const SectionLabel('¿POR QUÉ QUIERE HACERLA?'),
          const SizedBox(height: 8),
          Text(
            idea.why,
            style: GoogleFonts.dmSans(fontSize: 15, height: 1.55),
          ),
          const SizedBox(height: 28),
          const SectionLabel('¿A QUIÉN ESTÁ BUSCANDO?'),
          const SizedBox(height: 8),
          Text(
            idea.lookingFor,
            style: GoogleFonts.dmSans(fontSize: 15, height: 1.55),
          ),
          const SizedBox(height: 24),
          _TeachLearnBlock(
            canTeach: idea.canTeach.isNotEmpty ? idea.canTeach : author.canTeach,
            wantsToLearn:
                idea.wantsToLearn.isNotEmpty ? idea.wantsToLearn : author.wantsToLearn,
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.tealSoft.withValues(alpha: 0.55),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              '¿No tienes todas las habilidades?\nNo importa. Si conectas con la idea, puedes aprender lo demás.',
              style: GoogleFonts.dmSans(
                fontSize: 14,
                height: 1.45,
                color: AppColors.teal,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const SectionLabel('SKILLS (COMPLEMENTARIAS)'),
          const SizedBox(height: 8),
          TagWrap(tags: idea.skillsNiceToHave, ember: true),
        ],
      ),
      bottomNavigationBar: _isMine
          ? null
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          setState(() => widget.repo.saveIdea(idea.id));
                        },
                        icon: Icon(
                          widget.repo.savedIdeaIds.contains(idea.id)
                              ? Icons.visibility
                              : Icons.visibility_outlined,
                        ),
                        label: Text(
                          widget.repo.savedIdeaIds.contains(idea.id)
                              ? 'Guardada'
                              : 'Quiero conocer más',
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _connected ? null : _connect,
                        icon: Icon(
                          _connected ? Icons.favorite : Icons.favorite_border,
                        ),
                        label: Text(_connected ? 'Conectaste' : 'Conecto con la idea'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class _TeachLearnBlock extends StatelessWidget {
  const _TeachLearnBlock({
    required this.canTeach,
    required this.wantsToLearn,
  });

  final List<String> canTeach;
  final List<String> wantsToLearn;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionLabel('PUEDE ENSEÑAR'),
              const SizedBox(height: 8),
              TagWrap(tags: canTeach),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionLabel('QUIERE APRENDER'),
              const SizedBox(height: 8),
              TagWrap(tags: wantsToLearn, ember: true),
            ],
          ),
        ),
      ],
    );
  }
}

class _ConnectionSheet extends StatefulWidget {
  const _ConnectionSheet({required this.initiallySelected});

  final Set<ConnectionReason> initiallySelected;

  @override
  State<_ConnectionSheet> createState() => _ConnectionSheetState();
}

class _ConnectionSheetState extends State<_ConnectionSheet> {
  late final Set<ConnectionReason> _selected =
      {...widget.initiallySelected};

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.viewInsetsOf(context).bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('¿Qué te conectó con esta idea?', style: displayStyle(size: 22)),
          const SizedBox(height: 6),
          Text(
            'Puedes elegir varias. Esto alimenta el match por afinidad.',
            style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.muted),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final reason in ConnectionReason.values)
                FilterChip(
                  label: Text(reason.label),
                  selected: _selected.contains(reason),
                  onSelected: (v) {
                    setState(() {
                      if (v) {
                        _selected.add(reason);
                      } else {
                        _selected.remove(reason);
                      }
                    });
                  },
                  selectedColor: AppColors.teal,
                  checkmarkColor: Colors.white,
                  labelStyle: GoogleFonts.dmSans(
                    color: _selected.contains(reason)
                        ? Colors.white
                        : AppColors.ink,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _selected.isEmpty
                  ? null
                  : () => Navigator.pop(context, _selected.toList()),
              child: const Text('Enviar conexión'),
            ),
          ),
        ],
      ),
    );
  }
}
