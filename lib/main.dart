import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/app_widget.dart';

void main() async {
  runApp(
    const ProviderScope(
      child: AppWidget(),
    ),
  );
}
