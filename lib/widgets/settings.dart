import 'package:dlds/themes/app_themes.dart';
import 'package:dlds/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SettingsDialogue extends StatefulWidget {
  const SettingsDialogue({super.key});

  @override
  State<SettingsDialogue> createState() => _SettingsDialogueState();
}

class _SettingsDialogueState extends State<SettingsDialogue> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = Provider.of<ThemeProvider>(context);
    bool isDark = theme.isDark;
    return Dialog(
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 100,
        height: MediaQuery.of(context).size.height - 100,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isDark
                      ? LottieBuilder.asset(
                          "assets/animated/setting_white.json",
                          width: 16,
                        )
                      : LottieBuilder.asset(
                          "assets/animated/setting_black.json",
                          width: 16,
                        ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Settings",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Change Theme",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const Spacer(),
                  DropdownButton(
                    iconSize: 16,
                    underline: Container(color: Colors.transparent),
                    value: isDark,
                    borderRadius: BorderRadius.circular(5),
                    items: [true, false]
                        .map(
                          (e) => DropdownMenuItem(
                            alignment: AlignmentDirectional.center,
                            value: e,
                            child: Text(
                              e ? "Dark" : "Light",
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: ((value) => theme.setSelectedTheme(value!)),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Windows Transparency",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const Spacer(),
                  DropdownButton(
                    iconSize: 16,
                    underline: Container(color: Colors.transparent),
                    value: theme.effect,
                    borderRadius: BorderRadius.circular(5),
                    items: effects
                        .map(
                          (e) => DropdownMenuItem(
                            alignment: AlignmentDirectional.center,
                            value: e,
                            child: Text(
                              effectsStrings[e]!,
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: ((value) {
                      theme.setSelectedEffect(value!);
                    }),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
