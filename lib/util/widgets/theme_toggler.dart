import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oohwee/util/theme/theme_provider.dart';

class ThemeToggler extends ConsumerWidget {
  const ThemeToggler({
    super.key,
    this.size = 32,
  });
  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider);
    // var brightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode = themeMode == ThemeMode.dark;
    // const double size = 32;

    return GestureDetector(
      onTap: () => ref.read(themeNotifierProvider.notifier).toggleTheme(),
      child: Container(
        width: 65,
        height: size,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isDarkMode ? Colors.indigo[700] : Colors.grey[200],
          boxShadow: [
            BoxShadow(
              color: isDarkMode ? Colors.black26 : Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeInOut,
          alignment: isDarkMode ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDarkMode ? Colors.indigo[100] : Colors.white,
            ),
            child: Icon(
              size: 18,
              isDarkMode ? Icons.nightlight_round : Icons.wb_sunny,
              color: isDarkMode ? Colors.indigo[700] : Colors.yellow[700],
            ),
          ),
        ),
      ),
    );
  }
}
