import 'package:flutter/material.dart';

import 'package:swim_generator/swim_generator/swim_generator.dart';
import 'package:swim_generator/theme/dark_theme.dart';
import 'package:swim_generator/theme/light_theme.dart';
import 'dart:js' as js;


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  String _referrer = '';

  @override
  void initState() {
    super.initState();
    _getReferrer();
  }

  void _getReferrer() {
    setState(() {
      _referrer = js.context.callMethod('getReferrer');
    });
  }

  @override
  Widget build(BuildContext context) {
    // String herkunft = Uri.base.queryParameters['herkunft'] ?? 'Standard';
    // String titel = herkunft;

    // Überprüfen Sie, ob der Referrer einer der erlaubten URLs entspricht
    if (!isAllowedReferrer(_referrer)) {
      // Nicht erlaubter Zugriff, zeigen Sie eine entsprechende Nachricht an
      return const MaterialApp(
        home: Scaffold(
          body: Center(child: Text("Zugriff verweigert")),
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      darkTheme: darkMode,
      themeMode: _themeMode,
      home: SwimGeneratorPage(
        title: _referrer,
      ),
    );
  }

  void _handleBrightnessChange() {
    setState(() {
      _themeMode =
          (_themeMode == ThemeMode.light) ? ThemeMode.dark : ThemeMode.light;
    });
  }

  bool isAllowedReferrer(String referrer) {
    List<String> allowedReferrers = ["http://localhost:3000", "https://andere-erlaubte-website.com"];

    return allowedReferrers.any((allowedReferrer) => referrer.startsWith(allowedReferrer));
  }
}

class _BrightnessButton extends StatelessWidget {
  const _BrightnessButton({
    required this.handleBrightnessChange,
    required this.showTooltipBelow,
  });

  final VoidCallback handleBrightnessChange;
  final bool showTooltipBelow;

  @override
  Widget build(BuildContext context) {
    final isBright = Theme.of(context).brightness == Brightness.light;
    return Tooltip(
      preferBelow: showTooltipBelow,
      message: 'Toggle brightness',
      child: IconButton(
        icon: isBright
            ? Icon(Icons.dark_mode_outlined,
                color: Theme.of(context).iconTheme.color)
            : Icon(Icons.light_mode_outlined,
                color: Theme.of(context).iconTheme.color),
        onPressed: handleBrightnessChange,
      ),
    );
  }
}
