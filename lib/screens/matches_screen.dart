import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/mock_repository.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/person_avatar.dart';
import 'idea_detail_screen.dart';

class MatchesScreen extends StatelessWidget {
  const MatchesScreen({super.key, required this.repo});

  final MockRepository repo;

  @override
  Widget build(BuildContext context) {
    final matches = repo.matches;

    return Scaffold(
      appBar: AppBar(
        title: Text('Matches', style: displayStyle(size: 26)),
      ),
      body: matches.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                  'Aún no hay conexiones.\nCuando digas “Conecto con la idea”, aparecerán aquí.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dmSans(
                    fontSize: 15,
                    height: 1.5,
                    color: AppColors.muted,
                  ),
                ),
              ),
            )
          : ListView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
              children: [
                Text(
                  'Interés mutuo para conocerse — no es aún “somos equipo”.',
                  style: GoogleFonts.dmSans(
                    fontSize: 14,
                    color: AppColors.inkSoft,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),
                for (final match in matches) ...[
                  _MatchTile(
                    match: match,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => IdeaDetailScreen(
                            repo: repo,
                            idea: match.idea,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                ],
              ],
            ),
    );
  }
}

class _MatchTile extends StatelessWidget {
  const _MatchTile({required this.match, required this.onTap});

  final AffinityMatch match;
  final VoidCallback onTap;

  Color get _statusColor {
    switch (match.status) {
      case MatchStatus.mutual:
      case MatchStatus.chatting:
      case MatchStatus.meeting:
        return AppColors.success;
      case MatchStatus.pending:
        return AppColors.ember;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.paper,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.line),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  PersonAvatar(
                    name: match.other.name,
                    initials: match.other.initials,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          match.other.name,
                          style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          match.status.label,
                          style: GoogleFonts.dmSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _statusColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: AppColors.muted),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                match.idea.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  height: 1.35,
                ),
              ),
              if (match.note != null) ...[
                const SizedBox(height: 8),
                Text(
                  match.note!,
                  style: GoogleFonts.dmSans(
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                    color: AppColors.inkSoft,
                  ),
                ),
              ],
              const SizedBox(height: 10),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  for (final r in match.reasons)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.emberSoft,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        r.label,
                        style: GoogleFonts.dmSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.ember,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
