import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/mock_repository.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class MeetingScreen extends StatefulWidget {
  const MeetingScreen({super.key, required this.repo});

  final MockRepository repo;

  @override
  State<MeetingScreen> createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  Modality _modality = Modality.virtual;
  final _date = TextEditingController(text: 'Martes 30 sep');
  final _time = TextEditingController(text: '18:00');
  final _place = TextEditingController(text: 'Meet / Campus');
  final _message = TextEditingController(
    text: 'Me gustaría conversar sobre la idea y conocernos.',
  );

  @override
  void dispose() {
    _date.dispose();
    _time.dispose();
    _place.dispose();
    _message.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Proponer reunión', style: displayStyle(size: 22)),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          const SectionLabel('MODALIDAD'),
          ...[Modality.presencial, Modality.virtual].map(
            (m) => RadioListTile<Modality>(
              value: m,
              groupValue: _modality,
              onChanged: (v) => setState(() => _modality = v!),
              title: Text(m.label),
              activeColor: AppColors.violet,
              contentPadding: EdgeInsets.zero,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _date,
            decoration: const InputDecoration(hintText: 'Fecha'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _time,
            decoration: const InputDecoration(hintText: 'Hora'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _place,
            decoration: const InputDecoration(hintText: 'Lugar / enlace'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _message,
            maxLines: 4,
            decoration: const InputDecoration(
              hintText: 'Mensaje',
              fillColor: AppColors.violetSoft,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              widget.repo.proposeMeeting(
                MeetingProposal(
                  modality: _modality,
                  dateLabel: _date.text,
                  timeLabel: _time.text,
                  placeOrLink: _place.text,
                  message: _message.text,
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Reunión propuesta (simulación)',
                    style: GoogleFonts.dmSans(),
                  ),
                  backgroundColor: AppColors.violet,
                  behavior: SnackBarBehavior.floating,
                ),
              );
              Navigator.pop(context);
            },
            child: const Text('Proponer reunión'),
          ),
        ],
      ),
    );
  }
}
