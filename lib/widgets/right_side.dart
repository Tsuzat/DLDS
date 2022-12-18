import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:dlds/themes/app_themes.dart';
import 'package:dlds/themes/theme_provider.dart';
import 'package:dlds/widgets/right_side_widget.dart';
import 'package:dlds/widgets/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class RightSide extends StatefulWidget {
  const RightSide({Key? key}) : super(key: key);

  @override
  State<RightSide> createState() => _RightSideState();
}

class _RightSideState extends State<RightSide> {
  bool isHoveringSetting = false;
  bool animateTheme = false;

  late Widget setting;

  void setSettingIcon(bool isDark) {
    if (isHoveringSetting) {
      setting = isDark
          ? LottieBuilder.asset(
              "assets/animated/setting_white.json",
              repeat: true,
            )
          : LottieBuilder.asset(
              "assets/animated/setting_black.json",
              repeat: true,
            );
    } else {
      setting = isDark
          ? SvgPicture.asset(
              "assets/static/setting_white.svg",
            )
          : SvgPicture.asset(
              "assets/static/setting_black.svg",
            );
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context);
    bool isDark = theme.isDark;
    setSettingIcon(isDark);
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
                  child: SizedBox(
                    height: 16,
                    width: 16,
                    child: InkWell(
                      child: setting,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => const SettingsDialogue(),
                        );
                      },
                      onHover: (value) {
                        setState(() {
                          isHoveringSetting = value;
                          setState(() {
                            setSettingIcon(isDark);
                          });
                        });
                      },
                    ),
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
                            "assets/animated/moon_light.json",
                            width: 16,
                            height: 16,
                            animate: animateTheme,
                          )
                        : LottieBuilder.asset(
                            "assets/animated/sun.json",
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
