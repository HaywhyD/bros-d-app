import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../main.dart';
import '../../../models/service_categories.dart';
import '../../common/widgets.dart';

class ServiceCategoriesGrid extends StatelessWidget {
  final List<ServiceCategories> categories;

  const ServiceCategoriesGrid({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    int crossAxisCount = _getCrossAxisCount(context);

    return Container(
      color: Colors.grey.shade50,
      padding: EdgeInsets.symmetric(
          horizontal: _getHorizontalPadding(context),
          vertical: screenHeight * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Text(
              "Services Categories",
              style: textTheme.bodyLarge?.copyWith(
                fontSize: _getResponsiveFontSize(context, 24),
                fontWeight: FontWeight.bold,
                color: const Color(0xFFE74C3C),
              ),
            ),
          ),
          SizedBox(height: 30.h),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: 1,
              crossAxisSpacing: 20.w,
              mainAxisSpacing: 14.h,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return ServiceCategoryItem(
                category: categories[index],
                onTap: () {},
              );
            },
          ),
        ],
      ),
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width < 600) return 2; // Mobile
    if (width < 900) return 3; // Tablet
    return 4; // Desktop
  }

  double _getHorizontalPadding(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width < 600) return width * 0.03; // Mobile
    if (width < 900) return width * 0.05; // Tablet
    return width * 0.1; // Desktop
  }

  double _getResponsiveFontSize(BuildContext context, double size) {
    double width = MediaQuery.of(context).size.width;
    if (width < 600) return size * 0.8; // Mobile
    if (width < 900) return size * 0.9; // Tablet
    return size; // Desktop
  }
}
