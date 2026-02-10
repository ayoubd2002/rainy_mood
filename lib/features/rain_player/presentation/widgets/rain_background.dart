import 'dart:math';
import 'package:flutter/material.dart';

class RainBackground extends StatefulWidget {
  final Widget child;
  final bool isPlaying;

  const RainBackground({
    super.key,
    required this.child,
    this.isPlaying = false,
  });

  @override
  State<RainBackground> createState() => _RainBackgroundState();
}

class _RainBackgroundState extends State<RainBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<RainDrop> _rainDrops = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

    // Initialize rain drops
    _initializeRainDrops();
  }

  void _initializeRainDrops() {
    final random = Random();
    _rainDrops.clear();
    for (int i = 0; i < 100; i++) {
      _rainDrops.add(RainDrop(
        x: random.nextDouble(),
        y: random.nextDouble(),
        length: 20 + random.nextDouble() * 40,
        speed: 0.3 + random.nextDouble() * 0.5,
      ));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: RainPainter(
            rainDrops: _rainDrops,
            animationValue: _controller.value,
            isPlaying: widget.isPlaying,
          ),
          child: widget.child,
        );
      },
    );
  }
}

class RainDrop {
  double x;
  double y;
  double length;
  double speed;

  RainDrop({
    required this.x,
    required this.y,
    required this.length,
    required this.speed,
  });
}

class RainPainter extends CustomPainter {
  final List<RainDrop> rainDrops;
  final double animationValue;
  final bool isPlaying;

  RainPainter({
    required this.rainDrops,
    required this.animationValue,
    this.isPlaying = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isPlaying
          ? Colors.white.withOpacity(0.6)
          : Colors.white.withOpacity(0.3)
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    for (final drop in rainDrops) {
      final x = drop.x * size.width;
      var y = (drop.y + animationValue * drop.speed) * size.height;

      // Reset drop when it goes off screen
      if (y > size.height) {
        y = -drop.length;
      }

      // Draw rain drop line
      canvas.drawLine(
        Offset(x, y),
        Offset(x, y + drop.length),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(RainPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
        oldDelegate.isPlaying != isPlaying;
  }
}
