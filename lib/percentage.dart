import 'package:flutter/material.dart';

Widget percentage(
    {required Text title,
    required Color background,
    required Color foreground,
    required double width,
    required double height,
    required double maximum,
    required double borderRadius,
    required double value}) {
  return Stack(
    children: [
      Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(
            borderRadius,
          ),
        ),
      ),
      Container(
        width: width * (value / maximum),
        height: height,
        decoration: BoxDecoration(
          color: foreground,
          borderRadius: BorderRadius.circular(
            borderRadius,
          ),
        ),
      ),
      Container(
        height: height,
        width: width,
        child: title,
      )
    ],
  );
}
