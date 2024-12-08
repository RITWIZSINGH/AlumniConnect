// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';

class FieldBackground extends StatelessWidget {
  final String? field;
  final Widget child;
  final bool isExpanded;

  const FieldBackground({
    Key? key,
    required this.field,
    required this.child,
    this.isExpanded = false,
  }) : super(key: key);

  Widget _buildITBackground() {
    return Stack(
      children: [
        Positioned.fill(
          child: CustomPaint(
            painter: ITBackgroundPainter(isExpanded: isExpanded),
          ),
        ),
        child,
      ],
    );
  }

  Widget _buildCoreBackground() {
    return Stack(
      children: [
        Positioned.fill(
          child: CustomPaint(
            painter: CoreBackgroundPainter(isExpanded: isExpanded),
          ),
        ),
        child,
      ],
    );
  }

  Widget _buildResearchBackground() {
    return Stack(
      children: [
        Positioned.fill(
          child: CustomPaint(
            painter: ResearchBackgroundPainter(isExpanded: isExpanded),
          ),
        ),
        child,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (field?.toLowerCase()) {
      case 'it':
        return _buildITBackground();
      case 'core':
        return _buildCoreBackground();
      case 'research':
        return _buildResearchBackground();
      default:
        return child;
    }
  }
}

class ITBackgroundPainter extends CustomPainter {
  final bool isExpanded;

  ITBackgroundPainter({required this.isExpanded});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.blue.shade400.withValues(alpha: isExpanded ? 1 : 0.1),
          Colors.purple.shade400.withValues(alpha: isExpanded ? 1 : 0.1),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Offset.zero & size);

    final Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    // Add decorative elements for IT theme
    if (isExpanded) {
      final circlePaint = Paint()
        ..color = Colors.white.withValues(alpha: 0.1)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

      for (var i = 0; i < 5; i++) {
        canvas.drawCircle(
          Offset(size.width * 0.8, size.height * 0.2 + i * 30),
          10 + i * 5,
          circlePaint,
        );
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class CoreBackgroundPainter extends CustomPainter {
  final bool isExpanded;

  CoreBackgroundPainter({required this.isExpanded});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.orange.shade400.withValues(alpha: isExpanded ? 1 : 0.1),
          Colors.red.shade400.withValues(alpha: isExpanded ? 1 : 0.1),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Offset.zero & size);

    final Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    // Add decorative elements for Core theme
    if (isExpanded) {
      final gearPaint = Paint()
        ..color = Colors.white.withValues(alpha: 0.1)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

      for (var i = 0; i < 3; i++) {
        canvas.drawCircle(
          Offset(size.width * 0.1 + i * 50, size.height * 0.9),
          20,
          gearPaint,
        );
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class ResearchBackgroundPainter extends CustomPainter {
  final bool isExpanded;

  ResearchBackgroundPainter({required this.isExpanded});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.teal.shade400.withValues(alpha: isExpanded ? 1 : 0.1),
          Colors.green.shade400.withValues(alpha: isExpanded ? 1 : 0.1),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Offset.zero & size);

    final Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    // Add decorative elements for Research theme
    if (isExpanded) {
      final moleculePaint = Paint()
        ..color = Colors.white.withValues(alpha: 0.1)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

      for (var i = 0; i < 4; i++) {
        canvas.drawCircle(
          Offset(size.width * 0.8, size.height * 0.2 + i * 40),
          15,
          moleculePaint,
        );
        if (i > 0) {
          canvas.drawLine(
            Offset(size.width * 0.8, size.height * 0.2 + (i - 1) * 40),
            Offset(size.width * 0.8, size.height * 0.2 + i * 40),
            moleculePaint,
          );
        }
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}