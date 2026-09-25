import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/mock_repository.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import 'chat_screen.dart';

class ConnectionsScreen extends StatefulWidget {
  const ConnectionsScreen({
    super.key,
    required this.repo,
    required this.onChanged,
  });

  final MockRepository repo;
  final VoidCallback onChanged;

  @override
  State<ConnectionsScreen> createState() => _ConnectionsScreenState();
}

class _ConnectionsScreenState extends State<ConnectionsScreen> {
  ConnectionBucket _bucket = ConnectionBucket.nuevas;

  @override
  Widget build(BuildContext context) {
    final list =
        widget.repo.connections.where((c) => c.bucket == _bucket).toList();

    return Scaffold(
      backgroundColor: AppColors.bgSoft,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Text('Mis conexiones', style: displayStyle(size: 28)),
            ),
            const SizedBox(height: 14),
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  for (final b in ConnectionBucket.values)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(b.label),
                        selected: _bucket == b,
                        onSelected: (_) => setState(() => _bucket = b),
                        selectedColor: AppColors.violet,
                        labelStyle: GoogleFonts.dmSans(
                          color: _bucket == b
                              ? AppColors.white
                              : AppColors.black,
                          fontWeight: FontWeight.w600,
                        ),
                        backgroundColor: AppColors.white,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: list.isEmpty
                  ? Center(
                      child: Text(
                        'Aún no hay conexiones en esta sección.',
                        style: GoogleFonts.dmSans(color: AppColors.grayDark),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
                      itemCount: list.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (_, i) {
                        final c = list[i];
                        final names =
                            c.members.map((m) => m.name.split(' ').first).join(' · ');
                        return Material(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(18),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(18),
                            onTap: () async {
                              await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => ChatScreen(
                                    repo: widget.repo,
                                    connection: c,
                                  ),
                                ),
                              );
                              widget.onChanged();
                              setState(() {});
                            },
                            child: Container(
                              padding: const EdgeInsets.all(18),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(color: AppColors.grayLight),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Text('💜', style: TextStyle(fontSize: 16)),
                                      const SizedBox(width: 8),
                                      Text(
                                        c.project.codeName,
                                        style: GoogleFonts.dmSans(
                                          fontWeight: FontWeight.w800,
                                          color: AppColors.violetDeep,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    names,
                                    style: GoogleFonts.dmSans(
                                      fontSize: 14,
                                      color: AppColors.grayDark,
                                    ),
                                  ),
                                  if (c.lastMessage != null) ...[
                                    const SizedBox(height: 8),
                                    Text(
                                      c.lastMessage!,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.dmSans(fontSize: 13),
                                    ),
                                  ],
                                  const SizedBox(height: 12),
                                  Text(
                                    'Ver conversación →',
                                    style: GoogleFonts.dmSans(
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.violet,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
