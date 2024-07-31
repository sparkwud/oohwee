import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oohwee/util/theme/theme_provider.dart';

class AdvancedThemeToggle extends ConsumerStatefulWidget {
  const AdvancedThemeToggle({super.key});

  @override
  AdvancedThemeToggleState createState() => AdvancedThemeToggleState();
}

class AdvancedThemeToggleState extends ConsumerState<AdvancedThemeToggle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 750),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeNotifierProvider);
    final isDarkMode = themeMode == ThemeMode.dark;

    if (isDarkMode) {
      _controller.forward();
    } else {
      _controller.reverse();
    }

    return GestureDetector(
      onTap: () {
        ref.read(themeNotifierProvider.notifier).toggleTheme();
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Container(
            width: 80,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.lerp(
                    Colors.lightBlue[300],
                    Colors.indigo[900],
                    _animation.value,
                  )!,
                  Color.lerp(
                    Colors.lightBlue[100],
                    Colors.indigo[700],
                    _animation.value,
                  )!,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 750),
                  curve: Curves.easeInOut,
                  left: isDarkMode ? 40 : 0,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          isDarkMode ? Colors.indigo[100] : Colors.yellow[100],
                    ),
                    child: CustomPaint(
                      painter: _CelestialPainter(_animation.value),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CelestialPainter extends CustomPainter {
  final double animationValue;

  _CelestialPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.orange;

    // Draw sun/moon
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2,
      paint,
    );

    // Draw moon shadow
    if (animationValue > 0) {
      final shadowPaint = Paint()..color = Colors.indigo[300]!;
      final shadowOffset = Offset(size.width * 0.35 * animationValue, 0);
      canvas.drawCircle(
        Offset(size.width / 2, size.height / 2) + shadowOffset,
        size.width / 2,
        shadowPaint,
      );
    }

    // Draw sun rays or stars
    if (animationValue < 1) {
      final rayPaint = Paint()
        ..color = Colors.yellow[700]!
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke;

      for (int i = 0; i < 8; i++) {
        final angle = i * math.pi / 4;
        final rayLength = size.width * 0.2 * (1 - animationValue);
        canvas.drawLine(
          Offset(size.width / 2, size.height / 2),
          Offset(
            size.width / 2 + math.cos(angle) * rayLength,
            size.height / 2 + math.sin(angle) * rayLength,
          ),
          rayPaint,
        );
      }
    } else {
      final starPaint = Paint()..color = Colors.white;
      for (int i = 0; i < 5; i++) {
        final starX = size.width * (0.2 + 0.6 * math.Random().nextDouble());
        final starY = size.height * (0.2 + 0.6 * math.Random().nextDouble());
        canvas.drawCircle(Offset(starX, starY), 1, starPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class EnhancedThemeToggle extends ConsumerWidget {
  const EnhancedThemeToggle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider);
    final isDarkMode = themeMode == ThemeMode.dark;

    return GestureDetector(
      onTap: () {
        ref.read(themeNotifierProvider.notifier).toggleTheme();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 70,
        height: 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: isDarkMode ? Colors.indigo[700] : Colors.amber[300],
          boxShadow: [
            BoxShadow(
              color: isDarkMode ? Colors.black26 : Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              top: 3,
              left: isDarkMode ? 35 : 3,
              child: Container(
                width: 29,
                height: 29,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDarkMode ? Colors.indigo[100] : Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    isDarkMode ? Icons.nightlight_round : Icons.wb_sunny,
                    size: 20,
                    color: isDarkMode ? Colors.indigo[700] : Colors.amber[700],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
