import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:dlds/widgets/expanded_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// const sidebarColor = Color(0xFFF6A00C);

class LeftSide extends StatefulWidget {
  const LeftSide({Key? key}) : super(key: key);

  @override
  State<LeftSide> createState() => _LeftSideState();
}

class _LeftSideState extends State<LeftSide> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      child: Column(
        children: [
          WindowTitleBarBox(
            child: MoveWindow(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/icon.svg",
                      semanticsLabel: "DLDS LOGO",
                      width: 16,
                      height: 16,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Deep Learning Defect Sampling",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Projects",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                ExpandableListTile(
                  hoverColor: const Color.fromRGBO(92, 92, 92, 0.4),
                  leading: Image.asset(
                    "assets/light_on.png",
                    width: 16,
                    height: 16,
                  ),
                  title: const Text("Daily Checks"),
                  items: const [
                    Text("1"),
                    Text("2"),
                    Text("3"),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
