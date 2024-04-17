import 'package:chat_app/constant/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogoTextWidget extends StatelessWidget {
  const LogoTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(text: TextSpan(
        children: [
          TextSpan(
              text: 'Talk',style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 45.sp,
          )
          ),
          TextSpan(
              text: 'Hub',style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 45.sp,
              color: kPrimaryColor
          ))
        ]
    ));
  }
}
