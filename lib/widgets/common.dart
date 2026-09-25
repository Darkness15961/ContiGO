import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/models.dart';
import '../theme/app_theme.dart';

class PersonAvatar extends StatelessWidget {
  const PersonAvatar({
    super.key,
    required this.name,
    required this.initials,
    this.size = 44,
    this.photoUrl,
    this.localPhotoPath,
    this.student,
  });

  final String name;
  final String initials;
  final double size;
  final String? photoUrl;
  final String? localPhotoPath;
  final Student? student;

  factory PersonAvatar.fromStudent(Student student, {double size = 44}) {
    return PersonAvatar(
      name: student.name,
      initials: student.initials,
      size: size,
      photoUrl: student.photoUrl,
      localPhotoPath: student.localPhotoPath,
      student: student,
    );
  }

  String? get _local => localPhotoPath ?? student?.localPhotoPath;
  String? get _url => photoUrl ?? student?.photoUrl;

  @override
  Widget build(BuildContext context) {
    ImageProvider? image;
    final local = _local;
    final url = _url;

    if (local != null && local.isNotEmpty && File(local).existsSync()) {
      image = FileImage(File(local));
    } else if (url != null && url.isNotEmpty) {
      image = NetworkImage(url);
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.cream,
        border: Border.all(color: AppColors.white, width: size > 60 ? 3 : 0),
        boxShadow: size > 50
            ? [
                BoxShadow(
                  color: AppColors.deep.withValues(alpha: 0.12),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ]
            : null,
        image: image == null
            ? null
            : DecorationImage(image: image, fit: BoxFit.cover),
      ),
      alignment: Alignment.center,
      child: image != null
          ? null
          : Text(
              initials,
              style: GoogleFonts.dmSans(
                color: AppColors.deep,
                fontWeight: FontWeight.w700,
                fontSize: size * 0.34,
              ),
            ),
    );
  }
}

class ProjectCover extends StatelessWidget {
  const ProjectCover({
    super.key,
    required this.project,
    this.height = 140,
    this.borderRadius = 16,
  });

  final ProjectIdea project;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    ImageProvider? image;
    final local = project.localCoverPath;
    final url = project.coverUrl;

    if (local != null && local.isNotEmpty && File(local).existsSync()) {
      image = FileImage(File(local));
    } else if (url != null && url.isNotEmpty) {
      image = NetworkImage(url);
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: image == null
            ? Container(
                color: AppColors.cream,
                alignment: Alignment.center,
                child: Icon(
                  Icons.lightbulb_outline,
                  size: 40,
                  color: AppColors.primary.withValues(alpha: 0.7),
                ),
              )
            : Image(
                image: image,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: AppColors.cream,
                  alignment: Alignment.center,
                  child: const Icon(Icons.broken_image_outlined),
                ),
              ),
      ),
    );
  }
}

class SectionLabel extends StatelessWidget {
  const SectionLabel(this.text, {super.key, this.color});

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.dmSans(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: color ?? AppColors.grayDark,
        letterSpacing: 0.6,
      ),
    );
  }
}

class TagWrap extends StatelessWidget {
  const TagWrap({
    super.key,
    required this.tags,
    this.filled = true,
    this.asHashtags = false,
  });

  final List<String> tags;
  final bool filled;
  final bool asHashtags;

  @override
  Widget build(BuildContext context) {
    if (tags.isEmpty) return const SizedBox.shrink();
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final tag in tags)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: filled ? AppColors.cream : AppColors.white,
              borderRadius: BorderRadius.circular(20),
              border: filled ? null : Border.all(color: AppColors.grayLight),
            ),
            child: Text(
              asHashtags
                  ? (tag.startsWith('#') ? tag : '#$tag')
                  : tag,
              style: GoogleFonts.dmSans(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ),
      ],
    );
  }
}

/// Badge de sede / modalidad (color teal, distinto de violeta y naranja).
class MetaBadge extends StatelessWidget {
  const MetaBadge({
    super.key,
    required this.label,
    this.icon,
    this.filled = true,
  });

  final String label;
  final IconData? icon;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: filled ? AppColors.tealSoft : AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: filled ? AppColors.tealSoft : AppColors.teal,
          width: 1.2,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 13, color: AppColors.teal),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: GoogleFonts.dmSans(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: AppColors.teal,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}

class MetaBadgeRow extends StatelessWidget {
  const MetaBadgeRow({
    super.key,
    required this.province,
    required this.modality,
  });

  final CampusProvince province;
  final Modality modality;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 6,
      children: [
        MetaBadge(
          label: province.label,
          icon: Icons.location_on_outlined,
        ),
        MetaBadge(
          label: modality.label,
          icon: Icons.videocam_outlined,
          filled: false,
        ),
      ],
    );
  }
}

class ContigoScaffold extends StatelessWidget {
  const ContigoScaffold({
    super.key,
    required this.body,
    this.title,
    this.actions,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.backgroundColor,
  });

  final Widget body;
  final String? title;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? AppColors.white,
      appBar: title == null
          ? null
          : AppBar(
              title: Text(title!, style: displayStyle(size: 24)),
              actions: actions,
            ),
      body: body,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}

/// Selector de foto (galería / cámara) para simulación.
class PhotoPickerSheet extends StatelessWidget {
  const PhotoPickerSheet({super.key});

  static Future<ImageSourceChoice?> show(BuildContext context) {
    return showModalBottomSheet<ImageSourceChoice>(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const PhotoPickerSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Agregar imagen', style: displayStyle(size: 20)),
            const SizedBox(height: 8),
            Text(
              'Elige una foto desde tu dispositivo',
              style: GoogleFonts.dmSans(color: AppColors.grayDark, fontSize: 13),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: AppColors.cream,
                child: Icon(Icons.photo_library_outlined, color: AppColors.deep),
              ),
              title: const Text('Galería'),
              onTap: () => Navigator.pop(context, ImageSourceChoice.gallery),
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: AppColors.cream,
                child: Icon(Icons.photo_camera_outlined, color: AppColors.deep),
              ),
              title: const Text('Cámara'),
              onTap: () => Navigator.pop(context, ImageSourceChoice.camera),
            ),
          ],
        ),
      ),
    );
  }
}

/// Selector de sede / provincia.
class ProvinceChips extends StatelessWidget {
  const ProvinceChips({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final CampusProvince value;
  final ValueChanged<CampusProvince> onChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final p in CampusProvince.values)
          ChoiceChip(
            label: Text(p.label),
            selected: value == p,
            onSelected: (_) => onChanged(p),
            selectedColor: AppColors.primary,
            labelStyle: GoogleFonts.dmSans(
              color: value == p ? AppColors.white : AppColors.deep,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
            backgroundColor: AppColors.white,
            side: BorderSide(
              color: value == p ? AppColors.primary : AppColors.grayLight,
            ),
          ),
      ],
    );
  }
}

enum ImageSourceChoice { gallery, camera }

/// Selector de modalidad sin RadioListTile deprecado.
class ModalityChips extends StatelessWidget {
  const ModalityChips({
    super.key,
    required this.value,
    required this.onChanged,
    this.options = Modality.values,
  });

  final Modality value;
  final ValueChanged<Modality> onChanged;
  final List<Modality> options;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final m in options)
          ChoiceChip(
            label: Text(m.label),
            selected: value == m,
            onSelected: (_) => onChanged(m),
            selectedColor: AppColors.primary,
            labelStyle: GoogleFonts.dmSans(
              color: value == m ? AppColors.white : AppColors.deep,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
            backgroundColor: AppColors.white,
            side: BorderSide(
              color: value == m ? AppColors.primary : AppColors.grayLight,
            ),
          ),
      ],
    );
  }
}

