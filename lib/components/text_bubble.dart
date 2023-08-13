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
    return Row(
      // padding: EdgeInsets.only(
      //     top: 4,
      //     bottom: 4,
      //     left: widget.amISender ? 0 : 24,
      //     right: widget.amISender ? 24 : 0),
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment:
          widget.amISender ? MainAxisAlignment.end : MainAxisAlignment.start,
      // alignment:
      //     widget.amISender ? Alignment.centerRight : Alignment.centerLeft,
      children: [
        const SizedBox(
          height: 50,
          width: 15,
        ),
        !widget.amISender
            ? CircleAvatar(
                child: Text(widget.sender.substring(0, 1).toUpperCase()),
              )
            : Container(),
        !widget.amISender
            ? const SizedBox(
                width: 10,
              )
            : Container(),
        Container(
          // margin: widget.amISender
          //     ? const EdgeInsets.only(left: 30)
          //     : const EdgeInsets.only(right: 30),
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Theme.of(context).brightness == Brightness.dark
                  ? widget.amISender
                      ? darkColorScheme.primaryContainer
                      : darkColorScheme.secondaryContainer
                  : widget.amISender
                      ? lightColorScheme.primaryContainer
                      : lightColorScheme.secondaryContainer),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Text(
              //   widget.sender,
              //   style: const TextStyle(
              //     fontWeight: FontWeight.bold,
              //   ),
              //   textAlign: TextAlign.center,
              // ),
              Text(
                widget.message,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
        widget.amISender
            ? const SizedBox(
                width: 15,
              )
            : Container(),
      ],
    );
  }
}
