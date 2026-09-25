import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/mock_repository.dart';
import '../theme/app_theme.dart';
import '../widgets/project_card.dart';
import 'project_detail_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key, required this.repo, required this.onChanged});

  final MockRepository repo;
  final VoidCallback onChanged;

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final _query = TextEditingController();
  String? _category;

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final results = widget.repo.explore(query: _query.text, category: _category);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Text('Explorar', style: displayStyle(size: 28)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
              child: TextField(
                controller: _query,
                onChanged: (_) => setState(() {}),
                decoration: const InputDecoration(
                  hintText: 'Buscar proyectos...',
                  prefixIcon: Icon(Icons.search, color: AppColors.grayDark),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _FilterChip(
                    label: 'Todos',
                    selected: _category == null,
                    onTap: () => setState(() => _category = null),
                  ),
                  for (final c in widget.repo.categories)
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: _FilterChip(
                        label: c,
                        selected: _category == c,
                        onTap: () => setState(() => _category = c),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Divider(height: 1),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
                itemCount: results.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (_, i) {
                  final p = results[i];
                  return ProjectCard(
                    project: p,
                    interested: widget.repo.interestedProjectIds.contains(p.id),
                    showInterestButton: false,
                    onTap: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ProjectDetailScreen(
                            repo: widget.repo,
                            project: p,
                          ),
                        ),
                      );
                      widget.onChanged();
                      setState(() {});
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppColors.violet : AppColors.bgSoft,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: GoogleFonts.dmSans(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: selected ? AppColors.white : AppColors.grayDark,
          ),
        ),
      ),
    );
  }
}
