import 'package:flutter/material.dart';
import 'package:swim_generator/swim_generator/swim_generator.dart';
import 'package:swim_generator/theme/dark_theme.dart';
import 'package:swim_generator/theme/light_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeMode _themeMode = ThemeMode.system;

  bool get useLightMode {
    switch (_themeMode) {
      case ThemeMode.system:
        return MediaQuery.of(context).platformBrightness == Brightness.light;
      case ThemeMode.light:
        return true;
      case ThemeMode.dark:
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Demo',
      theme: lightMode,
      darkTheme: darkMode,
      themeMode: _themeMode,
      home: const SwimGeneratorPage(),
    );
  }
}

class _BrightnessButton extends StatelessWidget {
  const _BrightnessButton({
    required this.handleBrightnessChange, required this.showTooltipBelow,
  });

  final Function handleBrightnessChange;
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
        onPressed: () => handleBrightnessChange(!isBright),
      ),
    );
  }
}
