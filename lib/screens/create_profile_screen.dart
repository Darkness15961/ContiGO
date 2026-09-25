import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/mock_repository.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import 'shell_screen.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({
    super.key,
    required this.repo,
    this.isFirstTime = false,
  });

  final MockRepository repo;
  final bool isFirstTime;

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  late final TextEditingController _desc;
  late final TextEditingController _passions;
  late final TextEditingController _skills;
  late final TextEditingController _interests;
  late final TextEditingController _learn;
  late final TextEditingController _availability;
  late final TextEditingController _moves;
  late Modality _modality;

  @override
  void initState() {
    super.initState();
    final u = widget.repo.currentUser;
    _desc = TextEditingController(text: u.description);
    _passions = TextEditingController(text: u.passions);
    _skills = TextEditingController(text: u.skills.join(' · '));
    _interests = TextEditingController(text: u.interests.join(' · '));
    _learn = TextEditingController(text: u.wantsToLearn.join(' · '));
    _availability = TextEditingController(text: u.availability);
    _moves = TextEditingController(text: u.whatMovesYou);
    _modality = u.modality;
  }

  @override
  void dispose() {
    _desc.dispose();
    _passions.dispose();
    _skills.dispose();
    _interests.dispose();
    _learn.dispose();
    _availability.dispose();
    _moves.dispose();
    super.dispose();
  }

  List<String> _split(String raw) => raw
      .split(RegExp(r'[·,]'))
      .map((e) => e.trim())
      .where((e) => e.isNotEmpty)
      .toList();

  void _save() {
    final u = widget.repo.currentUser;
    widget.repo.updateProfile(
      Student(
        id: u.id,
        name: u.name,
        career: u.career,
        email: u.email,
        description: _desc.text.trim(),
        passions: _passions.text.trim(),
        whatMovesYou: _moves.text.trim(),
        skills: _split(_skills.text),
        interests: _split(_interests.text),
        wantsToLearn: _split(_learn.text),
        availability: _availability.text.trim(),
        modality: _modality,
      ),
    );
    if (widget.isFirstTime) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => ShellScreen(repo: widget.repo)),
      );
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isFirstTime ? 'Crear mi perfil' : 'Editar perfil',
          style: displayStyle(size: 22),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          Center(
            child: Column(
              children: [
                PersonAvatar(
                  name: widget.repo.currentUser.name,
                  initials: widget.repo.currentUser.initials,
                  size: 84,
                ),
                const SizedBox(height: 8),
                TextButton(onPressed: () {}, child: const Text('Agregar foto')),
              ],
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _desc,
            maxLines: 2,
            decoration: const InputDecoration(hintText: '¿Cómo te describes?'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _passions,
            decoration: const InputDecoration(hintText: '¿Qué te apasiona?'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _skills,
            decoration: const InputDecoration(hintText: '¿Qué habilidades tienes?'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _interests,
            decoration: const InputDecoration(hintText: '¿Qué temas te interesan?'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _learn,
            decoration: const InputDecoration(hintText: '¿Qué quieres aprender?'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _availability,
            decoration: const InputDecoration(hintText: '¿Cuándo tienes disponibilidad?'),
          ),
          const SizedBox(height: 16),
          const SectionLabel('MODALIDAD'),
          const SizedBox(height: 8),
          ...Modality.values.map(
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
          Text('¿Qué te mueve?', style: displayStyle(size: 22)),
          const SizedBox(height: 6),
          Text(
            'Esta será la parte humana del perfil.',
            style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.grayDark),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _moves,
            maxLines: 6,
            decoration: const InputDecoration(
              hintText: 'Escribe libremente…',
              fillColor: AppColors.violetSoft,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _save,
            child: Text(widget.isFirstTime ? 'Guardar y continuar' : 'Guardar cambios'),
          ),
        ],
      ),
    );
  }
}
