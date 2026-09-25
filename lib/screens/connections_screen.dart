import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/mock_repository.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/visual.dart';
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
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          ClipPath(
            clipper: WaveClipper(),
            child: BlotchBackground(
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 44),
                  child: Row(
                    children: [
                      const Icon(Icons.handshake, color: AppColors.white, size: 26),
                      const SizedBox(width: 10),
                      Text(
                        'Match',
                        style: GoogleFonts.dmSans(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 42,
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
                        color: _bucket == b ? AppColors.white : AppColors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                      backgroundColor: AppColors.white,
                      side: BorderSide.none,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          if (list.isEmpty)
            Padding(
              padding: const EdgeInsets.all(40),
              child: Text(
                'Aún no hay match en esta sección.',
                textAlign: TextAlign.center,
                style: GoogleFonts.dmSans(color: AppColors.grayDark),
              ),
            )
          else
            ...list.map((c) {
              final names =
                  c.members.map((m) => m.name.split(' ').first).join(' · ');
              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                child: SoftCard(
                  accentBar: AppColors.violet,
                  onTap: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) =>
                            ChatScreen(repo: widget.repo, connection: c),
                      ),
                    );
                    widget.onChanged();
                    setState(() {});
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.handshake_outlined,
                            color: AppColors.violet,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            c.project.codeName,
                            style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w800,
                              color: AppColors.violetDeep,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        names,
                        style: GoogleFonts.dmSans(
                          fontSize: 13,
                          color: AppColors.grayDark,
                        ),
                      ),
                      if (c.lastMessage != null) ...[
                        const SizedBox(height: 6),
                        Text(
                          c.lastMessage!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.dmSans(fontSize: 13),
                        ),
                      ],
                      const SizedBox(height: 8),
                      Text(
                        'Ver conversación →',
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w700,
                          color: AppColors.violet,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
