import 'package:chat_app/constant/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatTextFieldWidget extends StatefulWidget {
  final Function(String)? onSubmitted;
  final TextEditingController controller;

  const ChatTextFieldWidget({
    Key? key,
    this.onSubmitted,
    required this.controller,
  }) : super(key: key);

  @override
  _ChatTextFieldWidgetState createState() => _ChatTextFieldWidgetState();
}

class _ChatTextFieldWidgetState extends State<ChatTextFieldWidget> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: TextField(
        controller: widget.controller,
        focusNode: _focusNode,
        style: const TextStyle(color: Colors.white),
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: 'Send Message',
          prefixIcon: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.emoji_emotions_outlined),
          ),
          suffixIcon: IconButton(
            onPressed: () {
              if (widget.onSubmitted != null) {
                widget.onSubmitted!(widget.controller.text);
              }
            },
            icon: const Icon(Icons.send),
            color: kPrimaryColor,
          ),
          icon: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.mic),
          ),
          fillColor: kSecondaryColor,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100.r),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100.r),
          ),
        ),
        onSubmitted: (value) {
          if (widget.onSubmitted != null) {
            widget.onSubmitted!(value);
          }
        },
      ),
    );
  }
}
