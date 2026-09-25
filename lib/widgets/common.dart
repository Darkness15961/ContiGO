import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_theme.dart';

class PersonAvatar extends StatelessWidget {
  const PersonAvatar({
    super.key,
    required this.name,
    required this.initials,
    this.size = 44,
  });

  final String name;
  final String initials;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppColors.violetSoft,
        shape: BoxShape.circle,
      ),
      child: Text(
        initials,
        style: GoogleFonts.dmSans(
          color: AppColors.violetDeep,
          fontWeight: FontWeight.w700,
          fontSize: size * 0.34,
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
              color: filled ? AppColors.violetSoft : AppColors.white,
              borderRadius: BorderRadius.circular(20),
              border: filled ? null : Border.all(color: AppColors.grayLight),
            ),
            child: Text(
              tag,
              style: GoogleFonts.dmSans(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.violetDeep,
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
