import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../data/mock_repository.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';

class CreateProjectScreen extends StatefulWidget {
  const CreateProjectScreen({super.key, required this.repo});

  final MockRepository repo;

  @override
  State<CreateProjectScreen> createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  final _code = TextEditingController();
  final _title = TextEditingController();
  final _about = TextEditingController();
  final _why = TextEditingController();
  final _motivation = TextEditingController();
  final _looking = TextEditingController();
  final _knowledge = TextEditingController();
  Modality _modality = Modality.hibrida;
  String? _coverPath;
  final _picker = ImagePicker();

  @override
  void dispose() {
    _code.dispose();
    _title.dispose();
    _about.dispose();
    _why.dispose();
    _motivation.dispose();
    _looking.dispose();
    _knowledge.dispose();
    super.dispose();
  }

  Future<void> _pickCover() async {
    final choice = await PhotoPickerSheet.show(context);
    if (choice == null) return;
    final source = choice == ImageSourceChoice.camera
        ? ImageSource.camera
        : ImageSource.gallery;
    final file = await _picker.pickImage(
      source: source,
      maxWidth: 1600,
      imageQuality: 85,
    );
    if (file == null) return;
    setState(() => _coverPath = file.path);
  }

  void _publish() {
    final knowledge = _knowledge.text
        .split(RegExp(r'[·,]'))
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    widget.repo.publishProject(
      ProjectIdea(
        id: 'p-${DateTime.now().millisecondsSinceEpoch}',
        author: widget.repo.currentUser,
        codeName: _code.text.trim().isEmpty
            ? 'IDEA'
            : _code.text.trim().toUpperCase(),
        title: _title.text.trim().isEmpty ? 'Nueva idea' : _title.text.trim(),
        about: _about.text.trim(),
        why: _why.text.trim(),
        motivation: _motivation.text.trim(),
        lookingForPeople: _looking.text.trim(),
        categories: const ['Tecnología'],
        knowledgeAreas: knowledge,
        modality: _modality,
        localCoverPath: _coverPath,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tu idea fue publicada', style: GoogleFonts.dmSans()),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mist,
      appBar: AppBar(
        title: Text('Crear proyecto', style: displayStyle(size: 22)),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          Text('Cuéntanos tu idea', style: displayStyle(size: 28)),
          const SizedBox(height: 6),
          Text(
            'Más como contar una historia que llenar un formulario.',
            style: GoogleFonts.dmSans(fontSize: 14, color: AppColors.grayDark),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: _pickCover,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                height: 160,
                width: double.infinity,
                child: _coverPath != null
                    ? Image.file(File(_coverPath!), fit: BoxFit.cover)
                    : Container(
                        color: AppColors.cream,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.add_photo_alternate_outlined,
                                size: 36, color: AppColors.deep),
                            const SizedBox(height: 8),
                            Text(
                              'Agregar imagen de la idea',
                              style: GoogleFonts.dmSans(
                                fontWeight: FontWeight.w600,
                                color: AppColors.deep,
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _code,
            decoration: const InputDecoration(
              hintText: 'Título corto / nombre (ej. BRAILIT)',
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _title,
            maxLines: 2,
            decoration: const InputDecoration(hintText: '¿De qué trata?'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _about,
            maxLines: 3,
            decoration: const InputDecoration(hintText: 'Sobre la idea'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _why,
            maxLines: 3,
            decoration:
                const InputDecoration(hintText: '¿Por qué quieres hacerlo?'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _motivation,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: '¿Qué te motiva?',
              fillColor: AppColors.cream,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _looking,
            maxLines: 3,
            decoration: const InputDecoration(
              hintText: '¿Qué personas te gustaría encontrar?',
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _knowledge,
            decoration: const InputDecoration(
              hintText: '¿Qué conocimientos podrían aportar? (separados por ·)',
            ),
          ),
          const SizedBox(height: 16),
          const SectionLabel('MODALIDAD'),
          ...Modality.values.map(
            (m) => RadioListTile<Modality>(
              value: m,
              groupValue: _modality,
              onChanged: (v) => setState(() => _modality = v!),
              title: Text(m.label),
              activeColor: AppColors.primary,
              contentPadding: EdgeInsets.zero,
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: _publish,
            child: const Text('Publicar mi idea'),
          ),
        ],
      ),
    );
  }
}
