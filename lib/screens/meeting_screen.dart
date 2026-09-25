import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/mock_repository.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class MeetingScreen extends StatefulWidget {
  const MeetingScreen({
    super.key,
    required this.repo,
    required this.connection,
  });

  final MockRepository repo;
  final TeamConnection connection;

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
          Text(
            widget.connection.project.codeName,
            style: GoogleFonts.dmSans(
              color: AppColors.primary,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 12),
          const SectionLabel('MODALIDAD'),
          const SizedBox(height: 8),
          ModalityChips(
            value: _modality,
            onChanged: (v) => setState(() => _modality = v),
            options: const [Modality.presencial, Modality.virtual],
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _date,
            decoration: const InputDecoration(labelText: 'Fecha'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _time,
            decoration: const InputDecoration(labelText: 'Hora'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _place,
            decoration: const InputDecoration(labelText: 'Lugar / enlace'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _message,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: 'Mensaje',
              fillColor: AppColors.violetSoft,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              widget.repo.proposeMeeting(
                MeetingProposal(
                  connectionId: widget.connection.id,
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
                    'Reunión propuesta en el chat',
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
