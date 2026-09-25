import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/models.dart';
import '../theme/app_theme.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text('Solicitud de interés', style: displayStyle(size: 20)),
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
          Text('¿Qué te conectó con esta idea?', style: displayStyle(size: 26)),
          const SizedBox(height: 8),
          Text(
            'Cuéntale al creador por qué quieres conocer el proyecto.',
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
                    fontSize: 13,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _note,
            maxLines: 5,
            onChanged: (_) => setState(() {}),
            decoration: const InputDecoration(
              hintText:
                  'Ej: Me encanta el problema. No sé Braille, pero quiero aprender y ayudar a construirla.',
              fillColor: AppColors.violetSoft,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: (_note.text.trim().isEmpty && _reasons.isEmpty)
                ? null
                : () {
                    final text = _note.text.trim().isNotEmpty
                        ? _note.text.trim()
                        : _reasons.map((e) => e.label).join(' · ');
                    Navigator.pop(context, text);
                  },
            child: const Text('Enviar interés'),
          ),
        ],
      ),
    );
  }
}
