import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../main.dart';
import '../../../models/service_categories.dart';
import '../../core/assets/assets.dart';
import '../../core/utils/functions.dart';
import '../../models/professionals.dart';
import '../colors/colors.dart';
import 'text_fields.dart';

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

class ProfessionalCard extends StatelessWidget {
  final Professionals professional;
  final VoidCallback? onTap;
  final bool isSmallScreen;

  const ProfessionalCard({
    super.key,
    required this.professional,
    this.onTap,
    this.isSmallScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    final cardWidth = isSmallScreen ? 140.w : 180.w;
    final imageSize = isSmallScreen ? 70.r : 100.r;
    final fontSize = isSmallScreen ? 14.sp : 16.sp;
    final subtitleSize = isSmallScreen ? 12.sp : 14.sp;
    final starSize = isSmallScreen ? 16.r : 20.r;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cardWidth,
        margin: EdgeInsets.symmetric(
          horizontal: 8.w,
          vertical: 4.h,
        ),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: imageSize,
              height: imageSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: isSmallScreen ? 2.w : 4.w,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(imageSize / 2),
                child: Image.network(
                  professional.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade200,
                      child: Center(
                        child: Icon(
                          Icons.person,
                          color: Colors.grey.shade400,
                          size: isSmallScreen ? 30.r : 40.r,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: isSmallScreen ? 8.h : 12.h),
            Text(
              professional.title,
              style: textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
              ),
            ),
            SizedBox(height: isSmallScreen ? 2.h : 4.h),
            Text(
              professional.designation,
              style: textTheme.bodyLarge?.copyWith(
                color: Colors.grey.shade600,
                fontSize: subtitleSize,
              ),
            ),
            SizedBox(height: isSmallScreen ? 4.h : 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => Icon(
                  Icons.star,
                  color: index < professional.rating
                      ? Colors.amber
                      : Colors.grey.shade300,
                  size: starSize,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BrosDAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool isSticky;

  const BrosDAppBar({
    super.key,
    this.isSticky = false,
  });

  @override
  Size get preferredSize => Size.fromHeight(60.0);
  @override
  State<BrosDAppBar> createState() => _BrosDAppBarState();
}

class _BrosDAppBarState extends State<BrosDAppBar> {
  String? activeDropdown;
  final Map<String, GlobalKey> _menuKeys = {
    'product': GlobalKey(),
    'company': GlobalKey(),
    'help': GlobalKey(),
  };
  OverlayEntry? _overlayEntry;
  bool _isMenuOpen = false;
  double _previousWidth = 0;

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final width = MediaQuery.of(context).size.width;
    if (_previousWidth != width) {
      _removeOverlay();
      _previousWidth = width;
    }
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = MediaQuery.of(context).size;
        final isSmallScreen = constraints.maxWidth < 600;
        final isMediumScreen =
            constraints.maxWidth >= 600 && constraints.maxWidth < 900;

        // Update previous width for change detection
        _previousWidth = constraints.maxWidth;
        if (isSmallScreen) {
          return Builder(
            builder: (context) {
              return SizedBox(
                height: 100,
                child: AppBar(
                  toolbarHeight: 100,
                  centerTitle: true,
                  backgroundColor: Colors.white,
                  elevation: widget.isSticky ? 4.0 : 0.0,
                  title: SvgPicture.asset(
                    Assets.logo2,
                    height: 30,
                  ),
                  actions: [
                    IconButton(
                      icon: Icon(_isMenuOpen ? Icons.close : Icons.menu),
                      onPressed: () {
                        setState(() {
                          _isMenuOpen = !_isMenuOpen;
                        });
                        if (_isMenuOpen) {
                          _showMobileMenu(context);
                        } else {
                          _removeOverlay();
                        }
                      },
                    ),
                  ],
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(50),
                    child: Container(
                      color: AppColor.primaryColor,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 30,
                            width: size.width * 0.5,
                            child: ButtonWidget(
                              backgroundColor: Colors.white,
                              onPressed: () {},
                              borderRadius: BorderRadius.circular(20.r),
                              child: Text(
                                'Download Now',
                                style: textTheme.bodyLarge?.copyWith(
                                  color: AppColor.secondaryColor,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
        return SizedBox(
          height: 150,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 70,
                padding: EdgeInsets.symmetric(
                    horizontal: isMediumScreen ? 20 : 40, vertical: 10),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    isMediumScreen
                        ? IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {},
                          )
                        : SizedBox(
                            width: screenWidth * 0.3,
                            child: BrosDTextField(
                              suffixIcon: Icon(Icons.search),
                            ),
                          ),
                    Row(
                      children: [
                        if (!isMediumScreen)
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome Amanda Now',
                                style: textTheme.bodyLarge?.copyWith(
                                  color: AppColor.primaryColor,
                                ),
                              ),
                              Text(
                                formatDateTime(DateTime.now()),
                                style: textTheme.bodyMedium
                                    ?.copyWith(fontSize: 16.sp),
                              ),
                            ],
                          ),
                        SizedBox(width: isMediumScreen ? 20 : 100),
                        SvgPicture.asset(Assets.notificationIcon),
                        SizedBox(width: isMediumScreen ? 20 : 50),
                        Image.asset(
                          Assets.appIcon,
                          width: isMediumScreen ? 40.w : 64.w,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: isMediumScreen ? 20 : 40, vertical: 10),
                  color: AppColor.primaryColor,
                  child: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Logo
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: SvgPicture.asset(
                              Assets.logo,
                              height: 40,
                              fit: BoxFit.contain,
                            ),
                          ),

                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: isMediumScreen
                                  ? [
                                      _buildMenuItem('Home', null),
                                      _buildMenuItem('Menu ▼', 'product'),
                                    ]
                                  : [
                                      _buildMenuItem('Home', null),
                                      _buildMenuItem('Product ▼', 'product'),
                                      _buildMenuItem('Company ▼', 'company'),
                                      _buildMenuItem('Help ▼', 'help'),
                                    ],
                            ),
                          ),

                          SizedBox(
                            width: isMediumScreen
                                ? screenWidth * 0.2
                                : screenWidth * 0.1,
                            height: 40.h,
                            child: ButtonWidget(
                              backgroundColor: Colors.white,
                              onPressed: () {},
                              child: Text(
                                'Download Now',
                                style: textTheme.displayLarge?.copyWith(
                                  color: AppColor.secondaryColor,
                                  fontSize: isMediumScreen ? 14 : 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showMobileMenu(BuildContext context) {
    final size = MediaQuery.of(context).size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 100,
        left: 0,
        width: size.width,
        height: size.height - 100,
        child: ConstrainedBox(
          // Add this
          constraints: BoxConstraints(minWidth: 100, minHeight: 100),
          child: Material(
            color: Colors.white,
            child: Column(
              children: [
                ListTile(
                  title: Text('Home'),
                  onTap: () {
                    setState(() {
                      _isMenuOpen = false;
                    });
                    _removeOverlay();
                  },
                ),
                ExpansionTile(
                  title: Text('Product'),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Column(
                        children: [
                          ListTile(title: Text('Product Category 1')),
                          ListTile(title: Text('Product Category 2')),
                          ListTile(title: Text('Product Category 3')),
                        ],
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Text('Company'),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Column(
                        children: [
                          ListTile(title: Text('About Us')),
                          ListTile(title: Text('Team')),
                          ListTile(title: Text('Careers')),
                          ListTile(title: Text('News')),
                        ],
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Text('Help'),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Column(
                        children: [
                          ListTile(title: Text('FAQs')),
                          ListTile(title: Text('Support')),
                          ListTile(title: Text('Contact Us')),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  Widget _buildMenuItem(String title, String? dropdownKey) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    final isMediumScreen = MediaQuery.of(context).size.width >= 600 &&
        MediaQuery.of(context).size.width < 900;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 8.0 : 16.0),
      child: InkWell(
        key: dropdownKey != null ? _menuKeys[dropdownKey] : null,
        onTap: () {
          if (dropdownKey != null) {
            if (activeDropdown == dropdownKey) {
              setState(() {
                activeDropdown = null;
              });
              _removeOverlay();
            } else {
              setState(() {
                activeDropdown = dropdownKey;
              });
              _showDropdownMenu(dropdownKey);
            }
          }
        },
        onHover: (isHovering) {
          if (!(MediaQuery.of(context).size.width < 600)) {
            // Skip hover on mobile sizes
            if (isHovering && dropdownKey != null) {
              setState(() {
                activeDropdown = dropdownKey;
              });
              _showDropdownMenu(dropdownKey);
            } else if (!isHovering && dropdownKey != null) {
              Future.delayed(Duration(milliseconds: 100), () {
                if (!_isHoveringDropdown) {
                  setState(() {
                    activeDropdown = null;
                  });
                  _removeOverlay();
                }
              });
            }
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            title,
            style: textTheme.bodyLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: isMediumScreen ? 14 : 16,
            ),
          ),
        ),
      ),
    );
  }

  bool _isHoveringDropdown = false;

  void _showDropdownMenu(String dropdownKey) {
    _removeOverlay();

    if (_menuKeys[dropdownKey]?.currentContext == null) return;

    final RenderBox renderBox =
        _menuKeys[dropdownKey]!.currentContext!.findRenderObject() as RenderBox;
    final Size size = renderBox.size;
    final Offset position = renderBox.localToGlobal(Offset.zero);
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    final isMediumScreen = screenWidth >= 600 && screenWidth < 900;

    List<String> items = [];

    if (isMediumScreen && dropdownKey == 'product') {
      items = [
        'Product Category 1',
        'Product Category 2',
        'Product Category 3',
        '---', // Divider
        'About Us',
        'Team',
        'Careers',
        'News',
        '---', // Divider
        'FAQs',
        'Support',
        'Contact Us',
      ];
    } else {
      if (dropdownKey == 'product') {
        items = [
          'Product Category 1',
          'Product Category 2',
          'Product Category 3'
        ];
      } else if (dropdownKey == 'company') {
        items = ['About Us', 'Team', 'Careers', 'News'];
      } else if (dropdownKey == 'help') {
        items = ['FAQs', 'Support', 'Contact Us'];
      }
    }

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: position.dy + size.height,
        left: isMediumScreen && dropdownKey == 'product'
            ? (screenWidth - 250) / 2
            : position.dx - 50,
        width: isMediumScreen && dropdownKey == 'product' ? 250 : 200,
        child: Material(
          elevation: 0,
          color: Colors.transparent,
          child: MouseRegion(
            onEnter: (_) {
              _isHoveringDropdown = true;
            },
            onExit: (_) {
              _isHoveringDropdown = false;
              Future.delayed(Duration(milliseconds: 100), () {
                if (!_isHoveringDropdown) {
                  setState(() {
                    activeDropdown = null;
                  });
                  _removeOverlay();
                }
              });
            },
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: Duration(milliseconds: 200),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, -10 * (1 - value)),
                  child: Opacity(
                    opacity: value,
                    child: child,
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: items.map((item) {
                    if (item == '---') {
                      return Divider(height: 1, thickness: 1);
                    }
                    return _buildDropdownItem(item);
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  Widget _buildDropdownItem(String item) {
    return InkWell(
      onTap: () {
        _removeOverlay();
        setState(() {
          activeDropdown = null;
          _isMenuOpen = false;
        });
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Text(
          item,
          style: textTheme.bodyLarge?.copyWith(
            color: Colors.black87,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class BrosDFooter extends StatelessWidget {
  const BrosDFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600;
    final isMediumScreen = size.width >= 600 && size.width < 900;

    if (isSmallScreen) {
      return Container(
        color: Colors.black,
        padding:
            EdgeInsets.symmetric(vertical: 40, horizontal: size.width * 0.05),
        child: Column(
          children: [
            Image.asset(
              Assets.logo2,
              height: 30,
            ),
            SizedBox(height: 30),
            Text(
              'Speak to our Team',
              style: textTheme.displayLarge?.copyWith(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            _buildBrosDTextField('Full Name', isSmallScreen),
            SizedBox(height: 8),
            _buildBrosDTextField('Address', isSmallScreen),
            SizedBox(height: 8),
            _buildBrosDTextField('Email', isSmallScreen),
            SizedBox(height: 8),
            _buildBrosDTextField('Phone Number', isSmallScreen),
            SizedBox(height: 10),
            SizedBox(
              height: 50,
              width: 150,
              child: ButtonWidget(
                backgroundColor: AppColor.secondaryColor,
                onPressed: () {},
                child: Text('Submit'),
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Fast Links',
              style: textTheme.bodyLarge?.copyWith(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: [
                _buildFooterLink('Careers'),
                _buildFooterLink('Contact Us'),
                _buildFooterLink('WebApp'),
                _buildFooterLink('FAQs'),
                _buildFooterLink('About Us'),
              ],
            ),
            SizedBox(height: 24),
            _buildFooterLink('Download App', isBold: true),
            SizedBox(height: 40),
            Wrap(
              alignment: WrapAlignment.center,
              children: [
                _buildPolicyLink('Privacy Policy'),
                Text(' | ',
                    style: textTheme.bodyLarge?.copyWith(color: Colors.white)),
                _buildPolicyLink('Terms of Use'),
                Text(' | ',
                    style: textTheme.bodyLarge?.copyWith(color: Colors.white)),
                _buildPolicyLink('Refund Policy'),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'We\'re social:',
              style: textTheme.bodyLarge
                  ?.copyWith(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSocialIcon(Assets.youtubeIcon),
                _buildSocialIcon(Assets.threadIcon),
                _buildSocialIcon(Assets.facebookIcon),
                _buildSocialIcon(Assets.xIcon),
                _buildSocialIcon(Assets.instagramIcon),
              ],
            ),
          ],
        ),
      );
    }

    if (isMediumScreen) {
      return Container(
        color: Colors.black,
        padding:
            EdgeInsets.symmetric(vertical: 60, horizontal: size.width * 0.08),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left column - Contact form
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        Assets.logo2,
                        height: 30,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Speak to our Team',
                        style: textTheme.displayLarge?.copyWith(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15),
                      _buildBrosDTextField('Full Name', isSmallScreen),
                      SizedBox(height: 8),
                      _buildBrosDTextField('Email', isSmallScreen),
                      SizedBox(height: 8),
                      _buildBrosDTextField('Phone Number', isSmallScreen),
                      SizedBox(height: 10),
                      SizedBox(
                        height: 50,
                        width: 150,
                        child: ButtonWidget(
                          backgroundColor: AppColor.secondaryColor,
                          onPressed: () {},
                          child: Text('Submit'),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 20),

                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Fast Links',
                        style: textTheme.bodyLarge?.copyWith(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      _buildFooterLink('Careers'),
                      _buildFooterLink('Contact Us'),
                      _buildFooterLink('WebApp'),
                      _buildFooterLink('FAQs'),
                      _buildFooterLink('About Us'),
                      SizedBox(height: 24),
                      _buildFooterLink('Download App', isBold: true),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1),
              ),
              child: Column(
                children: [
                  // Policies
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      _buildPolicyLink('Privacy Policy'),
                      Text(' | ',
                          style: textTheme.bodyLarge
                              ?.copyWith(color: Colors.white)),
                      _buildPolicyLink('Terms of Use'),
                      Text(' | ',
                          style: textTheme.bodyLarge
                              ?.copyWith(color: Colors.white)),
                      _buildPolicyLink('Refund Policy'),
                    ],
                  ),

                  SizedBox(height: 20),

                  // Social Media
                  Text(
                    'We\'re social:',
                    style: textTheme.bodyLarge
                        ?.copyWith(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialIcon(Assets.youtubeIcon),
                      _buildSocialIcon(Assets.threadIcon),
                      _buildSocialIcon(Assets.facebookIcon),
                      _buildSocialIcon(Assets.xIcon),
                      _buildSocialIcon(Assets.instagramIcon),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      color: Colors.black,
      padding:
          EdgeInsets.symmetric(vertical: 100.0, horizontal: screenWidth * 0.1),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: Image.asset(
                        Assets.logo2,
                        height: 30,
                      ),
                    ),
                    Text(
                      'Speak to our Team',
                      style: textTheme.displayLarge?.copyWith(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15),
                    _buildBrosDTextField('Full Name', isSmallScreen),
                    SizedBox(height: 8),
                    _buildBrosDTextField('Address', isSmallScreen),
                    SizedBox(height: 8),
                    _buildBrosDTextField('Email', isSmallScreen),
                    SizedBox(height: 8),
                    _buildBrosDTextField('Phone Number', isSmallScreen),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 50,
                      width: 150,
                      child: ButtonWidget(
                        backgroundColor: AppColor.secondaryColor,
                        onPressed: () {},
                        child: Text('Submit'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 50),
              // Center section - Map
              Expanded(flex: 2, child: Image.asset(Assets.mapImage)),
              SizedBox(width: 50),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Fast Links',
                        style: textTheme.bodyLarge?.copyWith(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      _buildFooterLink('Careers'),
                      _buildFooterLink('Contact Us'),
                      _buildFooterLink('WebApp'),
                      _buildFooterLink('FAQs'),
                      _buildFooterLink('About Us'),
                      SizedBox(height: 24),
                      _buildFooterLink('Download App', isBold: true),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 40),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    _buildPolicyLink('Privacy Policy'),
                    Text(' | ',
                        style:
                            textTheme.bodyLarge?.copyWith(color: Colors.white)),
                    _buildPolicyLink('Terms of Use'),
                    Text(' | ',
                        style:
                            textTheme.bodyLarge?.copyWith(color: Colors.white)),
                    _buildPolicyLink('Refund Policy'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'We\'re social:',
                      style: textTheme.bodyLarge
                          ?.copyWith(color: Colors.white, fontSize: 16),
                    ),
                    SizedBox(width: 20),
                    Row(
                      children: [
                        _buildSocialIcon(Assets.youtubeIcon),
                        _buildSocialIcon(Assets.threadIcon),
                        _buildSocialIcon(Assets.facebookIcon),
                        _buildSocialIcon(Assets.xIcon),
                        _buildSocialIcon(Assets.instagramIcon),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBrosDTextField(String placeholder, bool isSmallScreen) {
    return SizedBox(
      width: isSmallScreen ? screenWidth * 0.8 : screenWidth * 0.3,
      child: BrosDTextField(
        hint: placeholder,
      ),
    );
  }

  Widget _buildFooterLink(String text, {bool isBold = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        text,
        style: textTheme.bodyLarge?.copyWith(
          color: Colors.white,
          fontSize: isBold ? 18 : 16,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildPolicyLink(String text) {
    return Text(
      text,
      style: textTheme.bodyLarge?.copyWith(color: Colors.white, fontSize: 14),
    );
  }

  Widget _buildSocialIcon(String icon) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6),
      child: icon.endsWith(".png")
          ? Image.asset(
              icon,
              width: 24.w,
            )
          : SvgPicture.asset(
              icon,
              width: 24.w,
            ),
    );
  }
}

class ServiceCategoryItem extends StatelessWidget {
  final ServiceCategories category;
  final VoidCallback? onTap;

  const ServiceCategoryItem({
    super.key,
    required this.category,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Use LayoutBuilder for more accurate responsive sizing
        final size = MediaQuery.of(context).size;
        final isSmallScreen = size.width < 600;
        final isMediumScreen = size.width >= 600 && size.width < 900;

        // Calculate proportional dimensions
        final containerWidth =
            isSmallScreen ? constraints.maxWidth : constraints.maxWidth * 0.9;
        final containerHeight = isSmallScreen
            ? containerWidth * 1.2 // Aspect ratio control
            : isMediumScreen
                ? containerWidth * 1.1
                : containerWidth;

        final ratingSize = isSmallScreen ? 32.0 : 40.0;

        return InkWell(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(
              maxHeight: containerHeight,
              minHeight: 100, // Ensure minimum size
            ),
            child: Padding(
              padding: EdgeInsets.all(isSmallScreen ? 4.0 : 8.0),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        flex: 7, // 70% for image
                        child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.all(isSmallScreen ? 4.0 : 8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: Image.asset(
                              category.imageUrl,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3, // 30% for text
                        child: Padding(
                          padding:
                              EdgeInsets.only(top: isSmallScreen ? 8.0 : 12.0),
                          child: Text(
                            category.title,
                            textAlign: TextAlign.center,
                            style: textTheme.bodyLarge?.copyWith(
                              fontSize: isSmallScreen ? 12.0 : 14.0,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: ratingSize,
                      height: ratingSize,
                      decoration: BoxDecoration(
                        color: Color(0xFF6AB04C),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          "${category.rating}",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: isSmallScreen ? 14.0 : 16.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
