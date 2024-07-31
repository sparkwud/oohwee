import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oohwee/features/home/views/home_view.dart';
import 'package:oohwee/util/constants.dart';
import 'package:oohwee/util/extensions/spacing_extensions.dart';
import 'package:oohwee/util/extensions/theme_extensions.dart';
import 'package:oohwee/util/navigate.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  SplashViewState createState() => SplashViewState();
}

class SplashViewState extends State<SplashView> {
  startTimeout() {
    return Timer(const Duration(seconds: 2), () => changeScreen());
  }

  changeScreen() async {
    Navigate.pushPageReplacement(context, const HomeView());
  }

  @override
  void initState() {
    super.initState();
    startTimeout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    AppConstants.imgPortal,
                    height: 200,
                    width: 200,
                  ),
                  const SizedBox(height: 16),
                  Hero(
                    tag: "splash",
                    child: Text(
                      AppConstants.appName,
                      style: context.h4!.copyWith(
                        // color: context.colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.spaceMono().fontFamily,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text(
            "A Rick and Morty App",
            style: context.sub2!.copyWith(
              // color: context.colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.spaceMono().fontFamily,
            ),
          ),
          16.spacing,
        ],
      ),
    );
  }
}
