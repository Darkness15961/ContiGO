import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/mock_repository.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import 'chat_screen.dart';
import 'meeting_screen.dart';

/// Solo se muestra cuando el creador ya registró el match.
class MatchScreen extends StatelessWidget {
  const MatchScreen({
    super.key,
    required this.repo,
    required this.project,
    required this.matchedWith,
    required this.connection,
  });

  final MockRepository repo;
  final ProjectIdea project;
  final Student matchedWith;
  final TeamConnection connection;

  @override
  Widget build(BuildContext context) {
    final me = repo.currentUser;

    return Scaffold(
      backgroundColor: AppColors.violetDeep,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28, 36, 28, 28),
          child: Column(
            children: [
              const Spacer(),
              Icon(
                Icons.handshake,
                size: 56,
                color: AppColors.cream,
                semanticLabel: 'Match',
              ),
              const SizedBox(height: 16),
              Text(
                '¡Match registrado!',
                style: displayStyle(size: 30, color: AppColors.white),
              ),
              const SizedBox(height: 8),
              Text(
                project.codeName,
                style: GoogleFonts.dmSans(
                  color: AppColors.cream,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _MatchPerson(student: me),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Text(
                      '+',
                      style: GoogleFonts.fraunces(
                        fontSize: 28,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                  _MatchPerson(student: matchedWith),
                ],
              ),
              const SizedBox(height: 28),
              Text(
                'Ya están en el mismo proyecto.\nPueden conversar o proponer una reunión.',
                textAlign: TextAlign.center,
                style: GoogleFonts.dmSans(
                  fontSize: 15,
                  height: 1.45,
                  color: AppColors.violetSoft,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.white,
                    foregroundColor: AppColors.violetDeep,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => ChatScreen(
                          repo: repo,
                          connection: connection,
                        ),
                      ),
                    );
                  },
                  child: const Text('Abrir chat'),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.white,
                    side: const BorderSide(color: AppColors.violetSoft),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => MeetingScreen(
                          repo: repo,
                          connection: connection,
                        ),
                      ),
                    );
                  },
                  child: const Text('Proponer reunión'),
                ),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Listo',
                  style: GoogleFonts.dmSans(color: AppColors.violetSoft),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MatchPerson extends StatelessWidget {
  const _MatchPerson({required this.student});

  final Student student;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PersonAvatar.fromStudent(student, size: 64),
        const SizedBox(height: 8),
        Text(
          student.name.split(' ').first,
          style: GoogleFonts.dmSans(
            color: AppColors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
