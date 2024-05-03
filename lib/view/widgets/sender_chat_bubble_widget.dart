import 'package:chat_app/models/message_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constant/colors.dart';

class SenderChatBubbleWidget extends StatelessWidget {
  const SenderChatBubbleWidget({
    super.key,required this.message,
  });
  final MessageModal message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.all(15.w),
        padding: EdgeInsets.all(15.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.r),
              topLeft: Radius.circular(20.r),
              bottomRight: Radius.circular(20.r),
            ),
            color: kPrimaryColor
        ),
        child: Column(
          children: [
            Text(message.message),
          ],
        ),
      ),
    );
  }
}
