import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/mock_repository.dart';
import '../theme/app_theme.dart';
import '../widgets/idea_card.dart';
import 'idea_detail_screen.dart';

class IdeasFeedScreen extends StatelessWidget {
  const IdeasFeedScreen({
    super.key,
    required this.repo,
    required this.onChanged,
  });

  final MockRepository repo;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    final ideas = repo.feedIdeas();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            title: Text('ContiGO', style: displayStyle(size: 26)),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Center(
                  child: Text(
                    'Mock',
                    style: GoogleFonts.dmSans(
                      fontSize: 12,
                      color: AppColors.muted,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ideas que podrían moverte',
                    style: displayStyle(size: 22),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Primero la persona y su motivación. Las skills vienen después.',
                    style: GoogleFonts.dmSans(
                      fontSize: 14,
                      color: AppColors.inkSoft,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
            sliver: SliverList.separated(
              itemCount: ideas.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final idea = ideas[index];
                return IdeaCard(
                  idea: idea,
                  connected: repo.connectedIdeaIds.contains(idea.id),
                  isMine: idea.author.id == repo.currentUser.id,
                  onTap: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => IdeaDetailScreen(
                          repo: repo,
                          idea: idea,
                        ),
                      ),
                    );
                    onChanged();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
