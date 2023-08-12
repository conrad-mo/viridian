import 'package:flutter/material.dart';

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
    return Container();
  }
}
