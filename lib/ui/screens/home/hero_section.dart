// Responsive Hero Section
import 'package:bros_d_app/core/assets/assets.dart';
import 'package:bros_d_app/ui/colors/colors.dart';
import 'package:bros_d_app/ui/common/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../main.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600;
    final isMediumScreen = size.width >= 600 && size.width < 900;

    if (isSmallScreen) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05,
          vertical: 30,
        ),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Artisans Onboarding",
              style: textTheme.bodyLarge?.copyWith(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16.h),
            _buildBulletPoint(
              "Access to a network of skilled local artisans,\nincluding electricians, plumbers, carpenters, and more.",
              context,
            ),
            SizedBox(height: 12.h),
            _buildBulletPoint(
              "Review your artisan profiles and schedule services\nfor home repairs, renovations, or specialized tasks.",
              context,
            ),
            SizedBox(height: 24.h),
            Center(
              child: Column(
                children: [
                  SizedBox(
                    width: size.width * 0.6,
                    height: 50.h,
                    child: ButtonWidget(
                      backgroundColor: AppColor.secondaryColor,
                      onPressed: () {},
                      child: Text(
                        "Discover More",
                        style: textTheme.bodyLarge?.copyWith(
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Image.asset(
                    Assets.downloadButton,
                    width: size.width * 0.6,
                  )
                ],
              ),
            ),
            SizedBox(height: 30.h),
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    child: Container(
                      width: size.width * 0.8,
                      height: 250.h,
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor.withOpacity(.5),
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                    ),
                  ),
                  Image.asset(
                    Assets.phone1,
                    height: 350.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    if (isMediumScreen) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.08,
          vertical: 40,
        ),
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Artisans Onboarding",
                    style: textTheme.bodyLarge?.copyWith(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  _buildBulletPoint(
                    "Access to a network of skilled local artisans,\n"
                    "including electricians, plumbers, carpenters, and more.",
                    context,
                  ),
                  SizedBox(height: 12.h),
                  _buildBulletPoint(
                    "Review your artisan profiles and schedule services\n"
                    "for home repairs, renovations, or specialized tasks.",
                    context,
                  ),
                  SizedBox(height: 24.h),
                  SizedBox(
                    width: 200.w,
                    height: 50.h,
                    child: ButtonWidget(
                      backgroundColor: AppColor.secondaryColor,
                      onPressed: () {},
                      child: Text(
                        "Discover More",
                        style: textTheme.bodyLarge?.copyWith(
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Image.asset(
                    Assets.downloadButton,
                    width: 200.w,
                  )
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: size.width * 0.3,
                    height: 300.h,
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor.withOpacity(.5),
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                  Image.asset(
                    Assets.phone1,
                    height: 350.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      width: double.infinity,
      height: screenHeight * 0.6,
      padding: EdgeInsets.only(
        left: screenWidth * 0.1.w,
        top: screenHeight * 0.1.h,
        bottom: screenHeight * 0.1.h,
      ),
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Artisans Onboarding",
                  style: textTheme.bodyLarge?.copyWith(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 16.h),
                _buildBulletPoint(
                  "Access to a network of skilled local artisans,\n"
                  "including electricians, plumbers, carpenters, and more.",
                  context,
                ),
                SizedBox(height: 12.h),
                _buildBulletPoint(
                  "Review your artisan profiles and schedule services\n"
                  "for home repairs, renovations, or specialized tasks.",
                  context,
                ),
                SizedBox(height: 24.h),
                SizedBox(
                  width: screenWidth * 0.15,
                  height: 60,
                  child: ButtonWidget(
                    backgroundColor: AppColor.secondaryColor,
                    onPressed: () {},
                    child: Text(
                      "Discover More",
                      style: textTheme.bodyLarge?.copyWith(
                        fontSize: 16.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                Image.asset(
                  Assets.downloadButton,
                  width: screenWidth * 0.2,
                )
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Stack(
              fit: StackFit.expand,
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  right: 0,
                  child: Container(
                    width: screenWidth * 0.4,
                    height: screenHeight * 0.4,
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor.withOpacity(.5),
                      borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(200.r),
                          bottomStart: Radius.circular(200.r)),
                      image: DecorationImage(
                          image: AssetImage(
                            Assets.heroImage,
                          ),
                          fit: BoxFit.cover,
                          alignment: Alignment.topRight),
                    ),
                    child: Container(
                      width: screenWidth * 0.3,
                      height: screenHeight * 0.3,
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor.withOpacity(.5),
                        borderRadius: BorderRadiusDirectional.only(
                            topStart: Radius.circular(200.r),
                            bottomStart: Radius.circular(200.r)),
                      ),
                      child: SizedBox.shrink(),
                    ),
                  ),
                ),
                Positioned(
                  right: screenWidth * 0.2,
                  top: -100,
                  child: Image.asset(
                    Assets.phone2,
                    width: 300.w,
                  ),
                ),
                Positioned(
                  right: screenWidth * 0.2 + 170,
                  child: Image.asset(
                    Assets.phone1,
                    width: 300.w,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text, BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return RichText(
      text: TextSpan(
        style: textTheme.bodyLarge?.copyWith(
          fontSize: isSmallScreen ? 14.sp : 16.sp,
          color: Colors.black87,
          height: 1.5,
        ),
        children: [
          TextSpan(
            text: "• ",
            style: textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          TextSpan(
            text: text,
            style: textTheme.bodyLarge?.copyWith(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
