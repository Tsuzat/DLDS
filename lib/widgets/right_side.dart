import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:dlds/themes/app_themes.dart';
import 'package:dlds/themes/theme_provider.dart';
import 'package:dlds/widgets/right_side_widget.dart';
import 'package:dlds/widgets/settings.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class RightSide extends StatefulWidget {
  const RightSide({Key? key}) : super(key: key);

  @override
  State<RightSide> createState() => _RightSideState();
}

class _RightSideState extends State<RightSide> {
  bool animateSetting = false;
  bool animateTheme = false;
  Widget setting = const Icon(
    Icons.settings,
    size: 20,
  );
  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context);
    bool isDark = theme.isDark;
    return Expanded(
      child: Column(
        children: [
          Container(
            height: 32,
            decoration: BoxDecoration(
              color: isDark ? DarkTheme.windowBar : LightTheme.windowBar,
              border: Border.all(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: MoveWindow(),
                ),

                Tooltip(
                  message: "Settings",
                  child: InkWell(
                    child: isDark
                        ? LottieBuilder.asset(
                            "assets/setting_lotti_dark.json",
                            width: 16,
                            animate: animateSetting,
                          )
                        : LottieBuilder.asset(
                            "assets/setting_lotti_light.json",
                            width: 16,
                            animate: animateSetting,
                          ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => const SettingsDialogue(),
                      );
                    },
                    onHover: (value) {
                      setState(() {
                        animateSetting = value;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Tooltip(
                  message: "Switch to ${isDark ? 'Light' : 'Dark'} Theme",
                  child: InkWell(
                    child: isDark
                        ? LottieBuilder.asset(
                            "assets/moon_light.json",
                            width: 16,
                            height: 16,
                            animate: animateTheme,
                          )
                        : LottieBuilder.asset(
                            "assets/sun.json",
                            width: 16,
                            height: 16,
                            animate: animateTheme,
                          ),
                    onTap: () {
                      theme.setSelectedTheme(!isDark);
                    },
                    onHover: (value) {
                      setState(() {
                        animateTheme = value;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                // IconButton(
                //   onPressed: () {
                //     theme.setSelectedTheme(!isDark);
                //   },
                //   icon: isDark
                //       ? const Icon(Icons.dark_mode_outlined)
                //       : const Icon(Icons.wb_sunny_outlined),
                //   tooltip: 'Switch to ${isDark ? "Light" : "Dark"} theme',
                //   iconSize: 16,
                // ),
                const WindowButtons(),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: isDark ? DarkTheme.mainAppBG : LightTheme.mainAppBG,
              child: const RightSideWidget(),
            ),
          ),
        ],
      ),
    );
  }
}

class WindowButtons extends StatefulWidget {
  const WindowButtons({super.key});

  @override
  State<WindowButtons> createState() => _WindowButtonsState();
}

class _WindowButtonsState extends State<WindowButtons> {
  void maximizeOrRestore() {
    setState(() {
      appWindow.maximizeOrRestore();
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context);
    bool isDark = theme.isDark;
    final buttonColors =
        isDark ? DarkTheme.buttonColors : LightTheme.buttonColors;
    final closeButtonColors =
        isDark ? DarkTheme.closeButtonColors : LightTheme.closeButtonColors;
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        appWindow.isMaximized
            ? RestoreWindowButton(
                colors: buttonColors,
                onPressed: maximizeOrRestore,
              )
            : MaximizeWindowButton(
                colors: buttonColors,
                onPressed: maximizeOrRestore,
              ),
        CloseWindowButton(colors: closeButtonColors),
      ],
    );
  }
}
