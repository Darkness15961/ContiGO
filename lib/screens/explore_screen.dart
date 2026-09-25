import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/mock_repository.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/project_card.dart';
import 'project_detail_screen.dart';

/// Único catálogo público: búsqueda + provincia + modalidad + #.
class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key, required this.repo, required this.onChanged});

  final MockRepository repo;
  final VoidCallback onChanged;

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final _query = TextEditingController();
  String? _hashtag;
  CampusProvince? _province;
  Modality? _modality;

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final results = widget.repo.explore(
      query: _query.text,
      hashtag: _hashtag,
      province: _province,
      modality: _modality,
    );

    return Scaffold(
      backgroundColor: AppColors.bgSoft,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Explorar', style: displayStyle(size: 28)),
                  const SizedBox(height: 4),
                  Text(
                    'Filtra por sede, modalidad y #',
                    style: GoogleFonts.dmSans(
                      fontSize: 13,
                      color: AppColors.grayDark,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
              child: TextField(
                controller: _query,
                onChanged: (_) => setState(() {}),
                decoration: const InputDecoration(
                  hintText: 'Buscar por nombre o idea...',
                  prefixIcon: Icon(Icons.search, color: AppColors.grayDark),
                ),
              ),
            ),
            const SizedBox(height: 10),
            _ChipRow(
              children: [
                _FilterChip(
                  label: 'Todas las sedes',
                  selected: _province == null,
                  onTap: () => setState(() => _province = null),
                ),
                for (final p in CampusProvince.values)
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: _FilterChip(
                      label: p.label,
                      selected: _province == p,
                      onTap: () => setState(() => _province = p),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            _ChipRow(
              children: [
                _FilterChip(
                  label: 'Cualquier modalidad',
                  selected: _modality == null,
                  onTap: () => setState(() => _modality = null),
                ),
                for (final m in Modality.values)
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: _FilterChip(
                      label: m.label,
                      selected: _modality == m,
                      onTap: () => setState(() => _modality = m),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            _ChipRow(
              children: [
                _FilterChip(
                  label: 'Todos #',
                  selected: _hashtag == null,
                  onTap: () => setState(() => _hashtag = null),
                ),
                for (final h in widget.repo.hashtagFeed)
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: _FilterChip(
                      label: h,
                      selected: _hashtag == h,
                      onTap: () => setState(() => _hashtag = h),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            const Divider(height: 1),
            Expanded(
              child: results.isEmpty
                  ? Center(
                      child: Text(
                        'Nada con ese filtro. Prueba otra sede o modalidad.',
                        style: GoogleFonts.dmSans(color: AppColors.grayDark),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
                      itemCount: results.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (_, i) {
                        final p = results[i];
                        final mine =
                            p.author.id == widget.repo.currentUser.id;
                        final interested = widget.repo.interestedProjectIds
                            .contains(p.id);
                        return ProjectCard(
                          project: p,
                          interested: interested,
                          showInterestButton: !mine && !interested,
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
                          onInterest: () async {
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => ProjectDetailScreen(
                                  repo: widget.repo,
                                  project: p,
                                  openInterest: true,
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

class _ChipRow extends StatelessWidget {
  const _ChipRow({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: children,
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
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: selected ? AppColors.violet : AppColors.white,
          borderRadius: BorderRadius.circular(20),
          border: selected ? null : Border.all(color: AppColors.grayLight),
        ),
        child: Text(
          label,
          style: GoogleFonts.dmSans(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: selected ? AppColors.white : AppColors.grayDark,
          ),
        ),
      ),
    );
  }
}
