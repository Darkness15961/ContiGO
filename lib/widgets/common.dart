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
  const TagWrap({super.key, required this.tags, this.filled = true});

  final List<String> tags;
  final bool filled;

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
              tag,
              style: GoogleFonts.dmSans(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.deep,
              ),
            ),
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

enum ImageSourceChoice { gallery, camera }
