import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Fondo violeta con “manchas” orgánicas + degradado (estilo ContiGO / mockup).
class BlotchBackground extends StatelessWidget {
  const BlotchBackground({
    super.key,
    this.child,
    this.height,
    this.borderRadius,
    this.intensity = 1,
  });

  final Widget? child;
  final double? height;
  final BorderRadius? borderRadius;
  final double intensity;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.violet,
                    AppColors.violetDeep,
                    Color(0xFF3A1785),
                  ],
                ),
              ),
            ),
            CustomPaint(
              painter: _BlotchPainter(intensity: intensity),
            ),
            if (child != null) child!,
          ],
        ),
      ),
    );
  }
}

class _BlotchPainter extends CustomPainter {
  _BlotchPainter({required this.intensity});

  final double intensity;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    void blotch(Offset c, double rx, double ry, Color color) {
      paint.color = color.withValues(alpha: color.a * intensity);
      final path = Path()
        ..addOval(Rect.fromCenter(center: c, width: rx * 2, height: ry * 2));
      canvas.drawPath(path, paint);
    }

    // Manchas grandes tipo liquid / organic
    blotch(
      Offset(size.width * 0.15, size.height * 0.2),
      size.width * 0.42,
      size.height * 0.38,
      const Color(0x55FFFFFF),
    );
    blotch(
      Offset(size.width * 0.85, size.height * 0.15),
      size.width * 0.38,
      size.height * 0.32,
      const Color(0x442A0F6E),
    );
    blotch(
      Offset(size.width * 0.7, size.height * 0.75),
      size.width * 0.45,
      size.height * 0.4,
      const Color(0x338B5CF6),
    );
    blotch(
      Offset(size.width * 0.05, size.height * 0.85),
      size.width * 0.35,
      size.height * 0.35,
      const Color(0x402A0F6E),
    );

    // Curva suave inferior (onda)
    final wave = Path()
      ..moveTo(0, size.height * 0.88)
      ..quadraticBezierTo(
        size.width * 0.25,
        size.height * 0.78,
        size.width * 0.5,
        size.height * 0.88,
      )
      ..quadraticBezierTo(
        size.width * 0.75,
        size.height * 0.98,
        size.width,
        size.height * 0.86,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    paint.color = const Color(0x22FFFFFF);
    canvas.drawPath(wave, paint);
  }

  @override
  bool shouldRepaint(covariant _BlotchPainter oldDelegate) =>
      oldDelegate.intensity != intensity;
}

/// Header violeta con manchas + contenido, borde inferior curvo hacia el body.
class ContigoHeroHeader extends StatelessWidget {
  const ContigoHeroHeader({
    super.key,
    required this.child,
    this.height = 220,
    this.bottomOverlap = 28,
  });

  final Widget child;
  final double height;
  final double bottomOverlap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: BlotchBackground(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

/// Card blanca con sombra suave (estilo mockup).
class SoftCard extends StatelessWidget {
  const SoftCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(18),
    this.onTap,
    this.accentBar,
    this.margin,
  });

  final Widget child;
  final EdgeInsets padding;
  final VoidCallback? onTap;
  final Color? accentBar;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    final card = Container(
      margin: margin,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: AppShadows.card,
      ),
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (accentBar != null)
              Container(width: 5, color: accentBar),
            Expanded(
              child: Padding(padding: padding, child: child),
            ),
          ],
        ),
      ),
    );

    if (onTap == null) return card;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: card,
      ),
    );
  }
}

class AppShadows {
  static List<BoxShadow> get card => [
        BoxShadow(
          color: AppColors.violetDeep.withValues(alpha: 0.08),
          blurRadius: 24,
          offset: const Offset(0, 10),
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ];
}

/// Ilustración abstracta “conexión” para login (sin assets externos).
class ConnectionIllustration extends StatelessWidget {
  const ConnectionIllustration({super.key, this.size = 160});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _ConnectionArtPainter()),
    );
  }
}

class _ConnectionArtPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final paint = Paint()..style = PaintingStyle.fill;

    // Círculos tipo clay / soft
    paint.color = const Color(0x55FFFFFF);
    canvas.drawCircle(Offset(cx - 28, cy + 8), 42, paint);
    canvas.drawCircle(Offset(cx + 30, cy + 4), 40, paint);

    paint.color = Colors.white.withValues(alpha: 0.92);
    canvas.drawCircle(Offset(cx - 28, cy), 34, paint);
    canvas.drawCircle(Offset(cx + 30, cy - 4), 32, paint);

    // Manos / vínculo (arco)
    final arc = Paint()
      ..color = AppColors.violetSoft
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCenter(center: Offset(cx, cy + 6), width: 70, height: 50),
      math.pi * 0.15,
      math.pi * 0.7,
      false,
      arc,
    );

    // Medalla / acento
    paint.color = const Color(0xFFFFC857);
    canvas.drawCircle(Offset(cx, cy - 48), 14, paint);
    paint.color = const Color(0xFFFFE6A3);
    canvas.drawCircle(Offset(cx, cy - 48), 8, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
