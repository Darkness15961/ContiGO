import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/models.dart';
import '../theme/app_theme.dart';

/// Nota + razones opcionales. El creador decide el match.
class InterestScreen extends StatefulWidget {
  const InterestScreen({super.key, required this.project});

  final ProjectIdea project;

  @override
  State<InterestScreen> createState() => _InterestScreenState();
}

class _InterestScreenState extends State<InterestScreen> {
  final _note = TextEditingController();
  final Set<ConnectionReason> _reasons = {};

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  bool get _canSend =>
      _note.text.trim().isNotEmpty || _reasons.isNotEmpty;

  void _submit() {
    final note = _note.text.trim();
    final reasons = _reasons.map((e) => e.label).join(' · ');
    final text = [
      if (reasons.isNotEmpty) reasons,
      if (note.isNotEmpty) note,
    ].join('\n');
    Navigator.pop(context, text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text('Me interesa', style: displayStyle(size: 20)),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
        children: [
          Text(
            widget.project.codeName,
            style: GoogleFonts.dmSans(
              color: AppColors.violet,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '¿Qué te conectó con esta idea?',
            style: displayStyle(size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            'Elige una o más razones y, si quieres, deja una nota. El creador registrará el match.',
            style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.grayDark),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final r in ConnectionReason.values)
                FilterChip(
                  label: Text(r.label),
                  selected: _reasons.contains(r),
                  onSelected: (v) {
                    setState(() {
                      if (v) {
                        _reasons.add(r);
                      } else {
                        _reasons.remove(r);
                      }
                    });
                  },
                  selectedColor: AppColors.violet,
                  checkmarkColor: AppColors.white,
                  labelStyle: GoogleFonts.dmSans(
                    color: _reasons.contains(r)
                        ? AppColors.white
                        : AppColors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _note,
            maxLines: 4,
            onChanged: (_) => setState(() {}),
            decoration: const InputDecoration(
              labelText: 'Nota (opcional si ya elegiste razones)',
              hintText:
                  'Ej: Me enamora el problema. No sé todo, pero quiero aprender.',
              fillColor: AppColors.violetSoft,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _canSend ? _submit : null,
            child: const Text('Enviar solicitud'),
          ),
        ],
      ),
    );
  }
}
