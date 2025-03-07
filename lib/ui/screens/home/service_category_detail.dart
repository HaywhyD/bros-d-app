import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../main.dart';
import '../../../models/service_categories.dart';
import '../../colors/colors.dart';
import '../../common/widgets.dart';

class CategoryDetailsWidget extends StatefulWidget {
  final ServiceCategories category;
  final Offset position;
  final Size size;
  final VoidCallback onClose;

  const CategoryDetailsWidget({
    super.key,
    required this.category,
    required this.position,
    required this.size,
    required this.onClose,
  });

  @override
  State<CategoryDetailsWidget> createState() => _CategoryDetailsWidgetState();
}

class _CategoryDetailsWidgetState extends State<CategoryDetailsWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _close() {
    _animationController.reverse().then((_) {
      widget.onClose();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;
    final isMediumScreen = screenSize.width >= 600 && screenSize.width < 900;

    final dialogWidth = isSmallScreen
        ? screenSize.width * 0.9
        : isMediumScreen
            ? screenSize.width * 0.8
            : screenSize.width * 0.7;

    final dialogHeight =
        isSmallScreen ? screenSize.height * 0.8 : screenSize.height * 0.9;

    int crossAxisCount = isSmallScreen
        ? 2
        : isMediumScreen
            ? 3
            : 3;

    return Positioned.fill(
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            GestureDetector(
              onTap: _close,
              child: AnimatedBuilder(
                animation: _opacityAnimation,
                builder: (context, child) {
                  return Container(
                    color:
                        Colors.black.withOpacity(0.5 * _opacityAnimation.value),
                  );
                },
              ),
            ),
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Center(
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Opacity(
                      opacity: _opacityAnimation.value,
                      child: child!,
                    ),
                  ),
                );
              },
              child: Container(
                width: dialogWidth,
                height: dialogHeight,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  border: Border.all(
                    color: AppColor.primaryColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: isSmallScreen ? 12 : 16,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor.withOpacity(0.2),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(14),
                          topRight: Radius.circular(14),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "${widget.category.title} Categories",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: isSmallScreen ? 18.sp : 22.sp,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          IconButton(
                            icon: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: isSmallScreen ? 18 : 24,
                              ),
                            ),
                            onPressed: _close,
                            tooltip: 'Close',
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: widget.category.details != null &&
                              widget.category.details!.isNotEmpty
                          ? Padding(
                              padding: EdgeInsets.all(isSmallScreen ? 8 : 10),
                              child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: crossAxisCount,
                                  childAspectRatio: 1,
                                  crossAxisSpacing: isSmallScreen ? 10 : 10,
                                  mainAxisSpacing: isSmallScreen ? 10 : 10,
                                ),
                                itemCount: widget.category.details!.length,
                                itemBuilder: (context, index) {
                                  return ServiceCategoryDetailItem(
                                    detail: widget.category.details![index],
                                    onTap: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              "Selected: ${widget.category.details![index].title}"),
                                          duration: Duration(seconds: 1),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            )
                          : Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.category_outlined,
                                    color: Colors.white.withOpacity(0.5),
                                    size: 48,
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    "No subcategories available",
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.7),
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: isSmallScreen ? 12 : 16,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor.withOpacity(0.2),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(14),
                          bottomRight: Radius.circular(14),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: screenWidth * 0.2,
                            child: ButtonWidget(
                              onPressed: _close,
                              child: Text(
                                "Close",
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 14.sp : 16.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryDetailOverlay {
  static OverlayEntry? _overlayEntry;

  static void show({
    required BuildContext context,
    required ServiceCategories category,
    required Offset position,
    required Size size,
  }) {
    hide();

    _overlayEntry = OverlayEntry(
      builder: (context) => CategoryDetailsWidget(
        category: category,
        position: position,
        size: size,
        onClose: hide,
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  static void hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
