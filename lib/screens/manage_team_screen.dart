import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/mock_repository.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import '../widgets/visual.dart';
import 'match_screen.dart';

/// El creador registra matches y gestiona miembros del proyecto.
class ManageTeamScreen extends StatefulWidget {
  const ManageTeamScreen({
    super.key,
    required this.repo,
    required this.project,
  });

  final MockRepository repo;
  final ProjectIdea project;

  @override
  State<ManageTeamScreen> createState() => _ManageTeamScreenState();
}

class _ManageTeamScreenState extends State<ManageTeamScreen> {
  ProjectIdea get project => widget.project;

  void _snack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: GoogleFonts.dmSans()),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mist,
      appBar: AppBar(
        title: Text('Equipo · ${project.codeName}', style: displayStyle(size: 20)),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          SoftCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${project.memberCount} / ${project.targetMembers} miembros',
                  style: displayStyle(size: 20),
                ),
                const SizedBox(height: 6),
                Text(
                  project.hasEnoughMembers
                      ? 'Ya tienes suficientes personas. Puedes quitar la publicación.'
                      : 'Cuando registres matches, las personas se vinculan al proyecto.',
                  style: GoogleFonts.dmSans(
                    fontSize: 13,
                    color: AppColors.grayDark,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: (project.memberCount / project.targetMembers)
                        .clamp(0.05, 1),
                    minHeight: 8,
                    backgroundColor: AppColors.cream,
                    color: project.hasEnoughMembers
                        ? AppColors.success
                        : AppColors.primary,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: project.isPublished
                            ? () {
                                setState(() {
                                  widget.repo.setPublished(project.id, false);
                                });
                                _snack('Publicación pausada');
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.orange,
                        ),
                        child: const Text('Quitar publicación'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: project.isPublished
                            ? null
                            : () {
                                setState(() {
                                  widget.repo.setPublished(project.id, true);
                                });
                                _snack('Proyecto publicado de nuevo');
                              },
                        child: const Text('Republicar'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text('Solicitudes de interés', style: displayStyle(size: 18)),
          const SizedBox(height: 6),
          Text(
            'Tú registras el match y vinculas a la persona al proyecto.',
            style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.grayDark),
          ),
          const SizedBox(height: 12),
          if (project.pendingRequests.isEmpty)
            SoftCard(
              child: Text(
                'No hay solicitudes pendientes.',
                style: GoogleFonts.dmSans(color: AppColors.grayDark),
              ),
            )
          else
            ...project.pendingRequests.map((req) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SoftCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          PersonAvatar.fromStudent(req.from, size: 44),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  req.from.name,
                                  style: GoogleFonts.dmSans(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  req.from.career,
                                  style: GoogleFonts.dmSans(
                                    fontSize: 12,
                                    color: AppColors.grayDark,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '"${req.note}"',
                        style: GoogleFonts.dmSans(
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                          color: AppColors.deep,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                final person = req.from;
                                final connection = widget.repo
                                    .acceptMatch(project.id, req.id);
                                if (!mounted) return;
                                setState(() {});
                                if (connection == null) return;
                                if (project.hasEnoughMembers) {
                                  _snack(
                                    'Cupo completo · publicación pausada',
                                  );
                                }
                                await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => MatchScreen(
                                      repo: widget.repo,
                                      project: project,
                                      matchedWith: person,
                                      connection: connection,
                                    ),
                                  ),
                                );
                                if (mounted) setState(() {});
                              },
                              icon: const Icon(Icons.handshake, size: 18),
                              label: const Text('Registrar match'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          OutlinedButton(
                            onPressed: () {
                              setState(() {
                                widget.repo.rejectInterest(project.id, req.id);
                              });
                            },
                            child: const Text('Descartar'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
          const SizedBox(height: 20),
          Text('Miembros del proyecto', style: displayStyle(size: 18)),
          const SizedBox(height: 12),
          ...project.members.map((m) {
            final isAuthor = m.id == project.author.id;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: SoftCard(
                child: Row(
                  children: [
                    PersonAvatar.fromStudent(m, size: 42),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            m.name,
                            style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            isAuthor ? 'Creador' : 'Miembro · match',
                            style: GoogleFonts.dmSans(
                              fontSize: 12,
                              color: AppColors.grayDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (!isAuthor)
                      IconButton(
                        tooltip: 'Quitar del proyecto',
                        onPressed: () {
                          final wasFull = project.hasEnoughMembers;
                          setState(() {
                            widget.repo.removeMember(project.id, m.id);
                          });
                          if (wasFull && project.isPublished) {
                            _snack('Cupo libre · proyecto publicado de nuevo');
                          }
                        },
                        icon: const Icon(Icons.person_remove_outlined,
                            color: AppColors.orange),
                      ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
