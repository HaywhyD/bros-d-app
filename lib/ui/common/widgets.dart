import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../colors/colors.dart';

class ButtonWidget extends StatelessWidget {
  final void Function()? onPressed;
  final Widget? child;
  final Color? backgroundColor;
  final bool? isOutlinedButton;
  final Color? borderColor;
  final EdgeInsets? padding;
  final BorderRadiusGeometry? borderRadius;
  const ButtonWidget({
    super.key,
    required this.onPressed,
    this.child,
    this.backgroundColor,
    this.isOutlinedButton,
    this.borderColor,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return (isOutlinedButton ?? false)
        ? OutlinedButton(
            onPressed: onPressed,
            style: ButtonStyle(
              shape: WidgetStateProperty.resolveWith(
                (states) => RoundedRectangleBorder(
                  borderRadius: borderRadius ?? BorderRadius.circular(10.r),
                ),
              ),
              textStyle: WidgetStatePropertyAll(
                  Theme.of(context).textTheme.bodyMedium),
              splashFactory: NoSplash.splashFactory,
            ),
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 60.h,
              decoration: ShapeDecoration(
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 2.w,
                    color: onPressed == null
                        ? AppColor.primaryColor.withOpacity(.5)
                        : borderColor ?? AppColor.primaryColor,
                  ),
                  borderRadius: borderRadius ?? BorderRadius.circular(10),
                ),
              ),
              child: child,
            ),
          )
        : ElevatedButton(
            onPressed: onPressed,
            style: ButtonStyle(
              padding: WidgetStateProperty.resolveWith(
                (states) => padding,
              ),
              shape: WidgetStateProperty.resolveWith(
                (states) => RoundedRectangleBorder(
                  borderRadius: borderRadius ?? BorderRadius.circular(10.r),
                ),
              ),
              textStyle: WidgetStatePropertyAll(
                  Theme.of(context).textTheme.bodyMedium),
              splashFactory: NoSplash.splashFactory,
            ),
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 60,
              decoration: ShapeDecoration(
                color: onPressed == null
                    ? AppColor.primaryColor.withOpacity(.5)
                    : backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: borderRadius ?? BorderRadius.circular(10.r),
                ),
              ),
              child: child,
            ),
          );
  }
}
