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
      padding: EdgeInsets.only(
          top: 4,
          bottom: 4,
          left: widget.amISender ? 0 : 24,
          right: widget.amISender ? 24 : 0),
      alignment:
          widget.amISender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        // margin: widget.amISender
        //     ? const EdgeInsets.only(left: 30)
        //     : const EdgeInsets.only(right: 30),
        padding:
            const EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Theme.of(context).brightness == Brightness.dark
                ? widget.amISender
                    ? darkColorScheme.primary
                    : darkColorScheme.secondaryContainer
                : widget.amISender
                    ? lightColorScheme.primary
                    : lightColorScheme.secondaryContainer),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.sender,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              widget.message,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
