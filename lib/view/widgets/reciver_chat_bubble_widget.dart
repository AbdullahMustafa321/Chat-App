import 'package:chat_app/constant/colors.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReciverChatBubbleWidget extends StatelessWidget {
  const ReciverChatBubbleWidget({
    super.key,required this.message,
  });
  final MessageModel message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.all(15.w),
        padding: EdgeInsets.all(15.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.r),
              topLeft: Radius.circular(20.r),
              bottomLeft: Radius.circular(20.r),
            ),
            color: kSecondaryColor
        ),
        child: Text(message.message),
      ),
    );
  }
}
