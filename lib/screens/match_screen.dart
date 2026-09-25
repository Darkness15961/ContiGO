import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/mock_repository.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import 'chat_screen.dart';
import 'meeting_screen.dart';

class MatchScreen extends StatelessWidget {
  const MatchScreen({
    super.key,
    required this.repo,
    required this.project,
  });

  final MockRepository repo;
  final ProjectIdea project;

  @override
  Widget build(BuildContext context) {
    final me = repo.currentUser;
    final other = project.author;
    TeamConnection? connection;
    for (final c in repo.connections) {
      if (c.project.id == project.id) {
        connection = c;
        break;
      }
    }

    return Scaffold(
      backgroundColor: AppColors.violetDeep,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28, 36, 28, 28),
          child: Column(
            children: [
              const Spacer(),
              const Text('💜', style: TextStyle(fontSize: 48)),
              const SizedBox(height: 16),
              Text(
                '¡Hicieron MATCH!',
                style: displayStyle(size: 32, color: AppColors.white),
              ),
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _MatchPerson(name: me.name, initials: me.initials),
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
                  _MatchPerson(name: other.name, initials: other.initials),
                ],
              ),
              const SizedBox(height: 28),
              Text(
                'Ambos quieren conocer\nmás sobre este proyecto.',
                textAlign: TextAlign.center,
                style: GoogleFonts.dmSans(
                  fontSize: 16,
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
                    final c = connection;
                    if (c == null) {
                      Navigator.pop(context);
                      return;
                    }
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => ChatScreen(
                          repo: repo,
                          connection: c,
                        ),
                      ),
                    );
                  },
                  child: const Text('Conocer al equipo'),
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
                        builder: (_) => MeetingScreen(repo: repo),
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
                  'Volver',
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
  const _MatchPerson({required this.name, required this.initials});

  final String name;
  final String initials;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PersonAvatar(name: name, initials: initials, size: 64),
        const SizedBox(height: 8),
        Text(
          name.split(' ').first,
          style: GoogleFonts.dmSans(
            color: AppColors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
