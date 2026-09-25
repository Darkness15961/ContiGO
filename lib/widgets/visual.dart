import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Fondo violeta con manchas orgánicas opacas (estilo mockup).
class BlotchBackground extends StatelessWidget {
  const BlotchBackground({
    super.key,
    this.child,
    this.height,
    this.borderRadius,
  });

  final Widget? child;
  final double? height;
  final BorderRadius? borderRadius;

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
            const ColoredBox(color: AppColors.violet),
            const CustomPaint(painter: _BlotchPainter()),
            if (child != null) child!,
          ],
        ),
      ),
    );
  }
}

class _BlotchPainter extends CustomPainter {
  const _BlotchPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Mancha grande superior-izquierda (como referencia)
    paint.color = AppColors.violetBlotch.withValues(alpha: 0.55);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.12, size.height * 0.05),
        width: size.width * 0.9,
        height: size.height * 0.7,
      ),
      paint,
    );

    // Mancha derecha
    paint.color = AppColors.violetDeep.withValues(alpha: 0.45);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.95, size.height * 0.35),
        width: size.width * 0.7,
        height: size.height * 0.75,
      ),
      paint,
    );

    // Mancha inferior suave
    paint.color = const Color(0x33FFFFFF);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.55, size.height * 1.05),
        width: size.width * 1.1,
        height: size.height * 0.55,
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Clip de ola inferior (login / headers).
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0, size.height - 36)
      ..quadraticBezierTo(
        size.width * 0.25,
        size.height,
        size.width * 0.5,
        size.height - 22,
      )
      ..quadraticBezierTo(
        size.width * 0.75,
        size.height - 44,
        size.width,
        size.height - 18,
      )
      ..lineTo(size.width, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class SoftCard extends StatelessWidget {
  const SoftCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.onTap,
    this.accentBar,
    this.margin,
    this.radius = 20,
  });

  final Widget child;
  final EdgeInsets padding;
  final VoidCallback? onTap;
  final Color? accentBar;
  final EdgeInsets? margin;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final content = Container(
      margin: margin,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: AppShadows.card,
        border: accentBar == null
            ? null
            : Border(left: BorderSide(color: accentBar!, width: 5)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(padding: padding, child: child),
    );

    if (onTap == null) return content;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(radius),
        child: content,
      ),
    );
  }
}

class AppShadows {
  static List<BoxShadow> get card => [
        BoxShadow(
          color: const Color(0xFF4F2FD6).withValues(alpha: 0.07),
          blurRadius: 18,
          offset: const Offset(0, 8),
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.03),
          blurRadius: 4,
          offset: const Offset(0, 1),
        ),
      ];
}

/// Ilustración simple tipo personajes + medalla (login).
class ConnectionIllustration extends StatelessWidget {
  const ConnectionIllustration({super.key, this.size = 170});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _StudentsPainter()),
    );
  }
}

class _StudentsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2 + 8;
    final paint = Paint()..style = PaintingStyle.fill;

    // Medalla
    paint.color = const Color(0xFFFFC857);
    canvas.drawCircle(Offset(cx, cy - 58), 16, paint);
    paint.color = const Color(0xFFFFE6A3);
    canvas.drawCircle(Offset(cx, cy - 58), 9, paint);
    paint.color = AppColors.violetDeep;
    final tp = TextPainter(
      text: const TextSpan(
        text: '1',
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Colors.white),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(cx - tp.width / 2, cy - 58 - tp.height / 2));

    // Cuerpo izquierdo
    paint.color = const Color(0xFFE8DEFF);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(cx - 32, cy + 18), width: 52, height: 70),
        const Radius.circular(18),
      ),
      paint,
    );
    paint.color = const Color(0xFFFFE0C2);
    canvas.drawCircle(Offset(cx - 32, cy - 18), 22, paint);

    // Cuerpo derecho
    paint.color = const Color(0xFFD4F5E9);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(cx + 34, cy + 16), width: 50, height: 68),
        const Radius.circular(18),
      ),
      paint,
    );
    paint.color = const Color(0xFFFFD8B5);
    canvas.drawCircle(Offset(cx + 34, cy - 20), 21, paint);

    // Libros
    paint.color = AppColors.violet;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(cx - 48, cy + 8, 18, 24),
        const Radius.circular(4),
      ),
      paint,
    );
    paint.color = AppColors.accentWarm;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(cx + 22, cy + 6, 18, 24),
        const Radius.circular(4),
      ),
      paint,
    );

    // Arco de conexión
    final arc = Paint()
      ..color = Colors.white.withValues(alpha: 0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCenter(center: Offset(cx, cy + 4), width: 56, height: 36),
      math.pi * 0.2,
      math.pi * 0.6,
      false,
      arc,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Header violeta con toolbar arriba y card debajo (sin tapar título/iconos).
/// La card vive dentro del bloque violeta, sobre la ola inferior.
class OverlapHeader extends StatelessWidget {
  const OverlapHeader({
    super.key,
    required this.toolbar,
    required this.overlapChild,
    this.bottomWaveSpace = 36,
  });

  final Widget toolbar;
  final Widget overlapChild;
  final double bottomWaveSpace;

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;

    return ClipPath(
      clipper: WaveClipper(),
      child: BlotchBackground(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, topInset, 0, bottomWaveSpace),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 48,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: toolbar,
                ),
              ),
              const SizedBox(height: 14),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: overlapChild,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
