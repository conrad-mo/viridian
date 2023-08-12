import 'package:flutter/material.dart';
import 'package:viridian/color_schemes.g.dart';

class TextBubble extends StatefulWidget {
  final String message;
  final String sender;
  final bool amISender;
  const TextBubble(
      {super.key,
      required this.message,
      required this.sender,
      required this.amISender});

  @override
  State<TextBubble> createState() => _TextBubbleState();
}

class _TextBubbleState extends State<TextBubble> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Theme.of(context).brightness == Brightness.dark
              ? widget.amISender
                  ? darkColorScheme.primary
                  : darkColorScheme.secondary
              : widget.amISender
                  ? lightColorScheme.primary
                  : lightColorScheme.secondary),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text(widget.sender)],
      ),
    );
  }
}
