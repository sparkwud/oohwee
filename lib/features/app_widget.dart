import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oohwee/features/home/views/splash_view.dart';
import 'package:oohwee/util/constants.dart';
import 'package:oohwee/util/theme/pallete.dart';
import 'package:oohwee/util/theme/theme_config.dart';
import 'package:oohwee/util/theme/theme_provider.dart';

import 'sample_feature/sample_item_details_view.dart';
import 'sample_feature/sample_item_list_view.dart';
import 'settings/settings_view.dart';

class AppWidget extends ConsumerWidget {
  const AppWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      themeMode: themeMode,
      // themeMode: ThemeMode.system,
      // theme: themeData(ThemeConfig.lightTheme),
      darkTheme: themeData(ThemeConfig.darkTheme),
      theme: RickAndMortyTheme.lightTheme,
      // darkTheme: RickAndMortyTheme.darkTheme,
      onGenerateRoute: (RouteSettings routeSettings) {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            switch (routeSettings.name) {
              case SettingsView.routeName:
                return const SettingsView();
              case SampleItemDetailsView.routeName:
                return const SampleItemDetailsView();
              case SampleItemListView.routeName:
              default:
                return const SplashView();
            }
          },
        );
      },
    );
  }

  ThemeData themeData(ThemeData theme) {
    return theme.copyWith(
      colorScheme: theme.colorScheme.copyWith(
        secondary: Pallete.lightAccent,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(
        theme.textTheme,
      ),
    );
  }
}
