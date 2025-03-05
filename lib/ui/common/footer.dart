// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget milsatFooter(ThemeData appTheme) {
  return Container(
    padding: EdgeInsets.only(top: 7.h, right: 10.w, left: 10.w),
    width: double.infinity,
    height: 32.h,
    decoration: BoxDecoration(
      color: appTheme.primaryColor,
    ),
    child: Text(
      'Powered by Milsat Technologies',
      textAlign: TextAlign.center,
      style: appTheme.textTheme.bodyLarge
          ?.copyWith(color: Colors.white, fontSize: 12.5.sp),
    ),
  );
}
