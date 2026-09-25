import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

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
  late final TextEditingController _name;
  late final TextEditingController _career;
  late final TextEditingController _desc;
  late final TextEditingController _passions;
  late final TextEditingController _skills;
  late final TextEditingController _interests;
  late final TextEditingController _learn;
  late final TextEditingController _availability;
  late final TextEditingController _moves;
  late Modality _modality;
  late CampusProvince _province;
  String? _localPhotoPath;
  String? _photoUrl;
  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    final u = widget.repo.currentUser;
    _name = TextEditingController(text: u.name);
    _career = TextEditingController(text: u.career);
    _desc = TextEditingController(text: u.description);
    _passions = TextEditingController(text: u.passions);
    _skills = TextEditingController(text: u.skills.join(' · '));
    _interests = TextEditingController(text: u.interests.join(' · '));
    _learn = TextEditingController(text: u.wantsToLearn.join(' · '));
    _availability = TextEditingController(text: u.availability);
    _moves = TextEditingController(text: u.whatMovesYou);
    _modality = u.modality;
    _province = u.province;
    _localPhotoPath = u.localPhotoPath;
    _photoUrl = u.photoUrl;
  }

  @override
  void dispose() {
    _name.dispose();
    _career.dispose();
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

  Future<void> _pickPhoto() async {
    final choice = await PhotoPickerSheet.show(context);
    if (choice == null) return;

    final source = choice == ImageSourceChoice.camera
        ? ImageSource.camera
        : ImageSource.gallery;

    final file = await _picker.pickImage(
      source: source,
      maxWidth: 1200,
      maxHeight: 1200,
      imageQuality: 85,
    );
    if (file == null) return;
    setState(() => _localPhotoPath = file.path);
  }

  void _save() {
    final u = widget.repo.currentUser;
    final name = _name.text.trim().isEmpty ? u.name : _name.text.trim();
    final career = _career.text.trim();
    final moves = _moves.text.trim();

    if (widget.isFirstTime && (career.isEmpty || moves.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Completa carrera y “¿Qué te mueve?” para continuar.',
            style: GoogleFonts.dmSans(),
          ),
          backgroundColor: AppColors.orange,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final interestsRaw = parseHashtags(_interests.text);
    final interests = interestsRaw.isNotEmpty
        ? interestsRaw
        : _split(_interests.text);

    widget.repo.updateProfile(
      u.copyWith(
        name: name,
        career: career.isEmpty ? u.career : career,
        description: _desc.text.trim(),
        passions: _passions.text.trim(),
        whatMovesYou: moves.isEmpty ? u.whatMovesYou : moves,
        skills: _split(_skills.text),
        interests: interests,
        wantsToLearn: _split(_learn.text),
        availability: _availability.text.trim(),
        modality: _modality,
        province: _province,
        photoUrl: _photoUrl,
        localPhotoPath: _localPhotoPath,
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
      backgroundColor: AppColors.mist,
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
                GestureDetector(
                  onTap: _pickPhoto,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      PersonAvatar(
                        name: _name.text,
                        initials: _name.text.isEmpty
                            ? '?'
                            : _name.text
                                .trim()
                                .split(' ')
                                .where((e) => e.isNotEmpty)
                                .take(2)
                                .map((e) => e[0].toUpperCase())
                                .join(),
                        size: 108,
                        photoUrl: _photoUrl,
                        localPhotoPath: _localPhotoPath,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: AppColors.white,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: _pickPhoto,
                  child: const Text('Subir foto de perfil'),
                ),
                Text(
                  'Galería o cámara — elige la imagen que quieras',
                  style: GoogleFonts.dmSans(
                    fontSize: 12,
                    color: AppColors.grayDark,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _name,
            decoration: const InputDecoration(hintText: 'Nombre'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _career,
            decoration: const InputDecoration(hintText: 'Carrera'),
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
            decoration:
                const InputDecoration(hintText: '¿Qué habilidades tienes?'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _interests,
            decoration: const InputDecoration(
              hintText: 'Intereses (#emprendimiento #social …)',
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _learn,
            decoration:
                const InputDecoration(hintText: '¿Qué quieres aprender?'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _availability,
            decoration: const InputDecoration(
              hintText: '¿Cuándo tienes disponibilidad?',
            ),
          ),
          const SizedBox(height: 16),
          const SectionLabel('SEDE / PROVINCIA'),
          const SizedBox(height: 8),
          ProvinceChips(
            value: _province,
            onChanged: (v) => setState(() => _province = v),
          ),
          const SizedBox(height: 16),
          const SectionLabel('MODALIDAD'),
          const SizedBox(height: 8),
          ModalityChips(
            value: _modality,
            onChanged: (v) => setState(() => _modality = v),
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
              fillColor: AppColors.cream,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _save,
            child: Text(
              widget.isFirstTime ? 'Guardar y continuar' : 'Guardar cambios',
            ),
          ),
        ],
      ),
    );
  }
}
