import 'package:flutter/material.dart';

class ExpandableListTile extends StatefulWidget {
  const ExpandableListTile({
    super.key,
    this.leading,
    this.title,
    this.decoration,
    this.items,
    this.hoverColor = const Color.fromARGB(255, 43, 43, 43),
    this.iconSize = 16,
    this.padding = const EdgeInsets.all(8.0),
    this.hoverBorderRadius = 5.0,
  });

  final Widget? leading;
  final Widget? title;
  final BoxDecoration? decoration;
  final List<Widget>? items;
  final Color hoverColor;
  final double iconSize;
  final EdgeInsets padding;
  final double hoverBorderRadius;

  @override
  State<ExpandableListTile> createState() => _ExpandableListTileState();
}

class _ExpandableListTileState extends State<ExpandableListTile> {
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: widget.decoration,
          padding: widget.padding,
          child: InkWell(
            hoverColor: widget.hoverColor,
            borderRadius: BorderRadius.circular(widget.hoverBorderRadius),
            onTap: () {
              _isExpanded = !_isExpanded;
              setState(() {});
            },
            child: Padding(
              padding: widget.padding,
              child: Row(
                children: [
                  widget.leading != null ? widget.leading! : const SizedBox(),
                  const SizedBox(
                    width: 10,
                  ),
                  widget.title != null ? widget.title! : const SizedBox(),
                  const Spacer(),
                  _isExpanded
                      ? Icon(
                          Icons.arrow_drop_up,
                          size: widget.iconSize,
                        )
                      : Icon(
                          Icons.arrow_drop_down,
                          size: widget.iconSize,
                        ),
                ],
              ),
            ),
          ),
        ),
        if (_isExpanded && widget.items != null)
          ...widget.items!
        else
          const SizedBox(),
      ],
    );
  }
}
