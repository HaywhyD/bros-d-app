// Responsive Professionals Carousel
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../main.dart';
import '../../../models/professionals.dart';
import '../../common/widgets.dart';

class ProfessionalsCarousel extends StatefulWidget {
  final List<Professionals> professionals;
  final String title;
  final Duration autoScrollDuration;
  final double scrollAmount;

  const ProfessionalsCarousel({
    super.key,
    required this.professionals,
    required this.title,
    this.autoScrollDuration = const Duration(seconds: 3),
    this.scrollAmount = 230.0,
  });

  @override
  State<ProfessionalsCarousel> createState() => _ProfessionalsCarouselState();
}

class _ProfessionalsCarouselState extends State<ProfessionalsCarousel> {
  final ScrollController _scrollController = ScrollController();
  Timer? _autoScrollTimer;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _stopAutoScroll();
    _scrollController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(widget.autoScrollDuration, (timer) {
      if (!_isHovering && _scrollController.hasClients) {
        final double maxScroll = _scrollController.position.maxScrollExtent;
        final double currentPosition = _scrollController.offset;
        final double targetPosition = currentPosition + widget.scrollAmount;

        if (targetPosition >= maxScroll) {
          _scrollController.animateTo(
            0,
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
          );
        } else {
          _scrollController.animateTo(
            targetPosition,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  void _stopAutoScroll() {
    _autoScrollTimer?.cancel();
    _autoScrollTimer = null;
  }

  void _handleHover(bool isHovering) {
    setState(() {
      _isHovering = isHovering;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600;
    final isMediumScreen = size.width >= 600 && size.width < 900;

    final horizontalPadding = isSmallScreen
        ? size.width * 0.05
        : isMediumScreen
            ? size.width * 0.08
            : screenWidth * 0.1;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: isSmallScreen ? 30 : 50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 8.w : 16.w,
              vertical: isSmallScreen ? 8.h : 16.h,
            ),
            child: Text(
              widget.title,
              style: textTheme.bodyLarge?.copyWith(
                fontSize: isSmallScreen ? 20.sp : 24.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          MouseRegion(
            onEnter: (_) => _handleHover(true),
            onExit: (_) => _handleHover(false),
            child: SizedBox(
              height: isSmallScreen ? 180.h : 220.h,
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                itemCount: widget.professionals.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      ProfessionalCard(
                        professional: widget.professionals[index],
                        onTap: () {
                          // Handle card tap
                        },
                        isSmallScreen: isSmallScreen,
                      ),
                      SizedBox(
                        width: isSmallScreen ? 20 : 50,
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
