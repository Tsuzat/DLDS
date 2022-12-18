import 'package:flutter/material.dart';

class RightSideWidget extends StatefulWidget {
  const RightSideWidget({super.key});

  @override
  State<RightSideWidget> createState() => _RightSideWidgetState();
}

class _RightSideWidgetState extends State<RightSideWidget> {
  @override
  Widget build(BuildContext context) {
    // ThemeProvider theme = Provider.of<ThemeProvider>(context);
    // bool isDark = theme.isDark;
    return const Center(
      child: Text("Hello World"),
    );
  }
}
