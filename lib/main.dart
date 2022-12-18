import 'package:dlds/themes/app_themes.dart';
import 'package:dlds/themes/theme_provider.dart';
import 'package:dlds/widgets/left_side.dart';
import 'package:dlds/widgets/right_side.dart';
import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:provider/provider.dart';

void main() async {
  // Ensure the Initialization
  WidgetsFlutterBinding.ensureInitialized();
  await Window.initialize();

  runApp(const MyApp());

  // Initialise the Window of the application
  // and it's properties for custom window
  doWhenWindowReady(() {
    final win = appWindow;
    const initialSize = Size(750, 550);
    win.minSize = initialSize;
    win.size = initialSize;
    win.alignment = Alignment.center;
    win.title = "DLDS";
    win.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Here adding a state manager using `Provider`
    /// to keep the track of different setting
    /// across the application
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MaterialAppWithTheme(),
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  const MaterialAppWithTheme({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context);
    bool isDark = theme.isDark;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDark ? DarkTheme.theme : LightTheme.theme,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void setWindowEffect(WindowEffect value, Color color, bool isDark) {
    Window.setEffect(
      effect: value,
      color: color,
      dark: isDark,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context);
    Color sidebarColor =
        theme.isDark ? DarkTheme.sidebarBG : LightTheme.sidebarBG;
    WindowEffect effect = theme.effect;
    setWindowEffect(effect, sidebarColor, theme.isDark);
    Color borderColor = theme.isDark
        ? const Color.fromARGB(255, 60, 60, 60)
        : const Color.fromARGB(255, 220, 220, 220);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: WindowBorder(
        color: borderColor,
        width: 1,
        child: Row(
          children: const [
            LeftSide(),
            RightSide(),
          ],
        ),
      ),
    );
  }
}
