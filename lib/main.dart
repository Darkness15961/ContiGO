import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'data/mock_repository.dart';
import 'screens/onboarding_screen.dart';
import 'screens/shell_screen.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const ContigoApp());
}

class ContigoApp extends StatefulWidget {
  const ContigoApp({super.key});

  @override
  State<ContigoApp> createState() => _ContigoAppState();
}

class _ContigoAppState extends State<ContigoApp> {
  final MockRepository repo = MockRepository();
  bool _seenOnboarding = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ContiGO',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: _seenOnboarding
          ? ShellScreen(repo: repo)
          : OnboardingScreen(
              onContinue: () => setState(() => _seenOnboarding = true),
            ),
      builder: (context, child) {
        return DefaultTextStyle(
          style: GoogleFonts.dmSans(color: AppColors.ink),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
