// Responsive Home Screen
import 'package:flutter/material.dart';

import '../../../core/assets/assets.dart';
import '../../../models/professionals.dart';
import '../../../models/service_categories.dart';
import '../../common/widgets.dart';
import 'hero_section.dart';
import 'professional_carousel.dart';
import 'service_categories.dart';

class HomeScreen extends StatefulWidget {
  static String name = 'home-screen';
  static String route = '/$name';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isAppBarSticky = false;

  final List<ServiceCategories> _serviceCategories = [
    const ServiceCategories(
        title: "Conruction and Building",
        imageUrl: Assets.category1,
        rating: 4,
        details: [
          ServiceCategoryDetail(
            title: "Bricklayers",
            imageUrl: Assets.bricklayer,
            rating: 4,
          ),
          ServiceCategoryDetail(
            title: "Carpenters",
            imageUrl: Assets.carpenter,
            rating: 4,
          ),
          ServiceCategoryDetail(
            title: "Civil Engineering",
            imageUrl: Assets.engineer,
            rating: 4,
          ),
          ServiceCategoryDetail(
            title: "Plumbers",
            imageUrl: Assets.plumber,
            rating: 4,
          ),
          ServiceCategoryDetail(
            title: "Welders",
            imageUrl: Assets.welder,
            rating: 4,
          ),
          ServiceCategoryDetail(
            title: "Roofers",
            imageUrl: Assets.roof,
            rating: 4,
          ),
          ServiceCategoryDetail(
            title: "Tilers",
            imageUrl: Assets.tiler,
            rating: 4,
          ),
          ServiceCategoryDetail(
            title: "Painter",
            imageUrl: Assets.painter,
            rating: 4,
          ),
          ServiceCategoryDetail(
            title: "POP Screeding",
            imageUrl: Assets.pop,
            rating: 4,
          ),
          ServiceCategoryDetail(
            title: "Concrete Work",
            imageUrl: Assets.concrete,
            rating: 4,
          ),
          ServiceCategoryDetail(
            title: "Scaffolding",
            imageUrl: Assets.scaffold,
            rating: 4,
          ),
        ]),
    const ServiceCategories(
      title: "Domestic Services",
      imageUrl: Assets.category2,
      rating: 4,
    ),
    const ServiceCategories(
      title: "Unskilled professions",
      imageUrl: Assets.category3,
      rating: 4,
    ),
    const ServiceCategories(
      title: "Event Planning & Management",
      imageUrl: Assets.category4,
      rating: 4,
    ),
    const ServiceCategories(
      title: "Mechanical",
      imageUrl: Assets.category5,
      rating: 4,
    ),
    const ServiceCategories(
      title: "Craftsmanship",
      imageUrl: Assets.category6,
      rating: 4,
    ),
    const ServiceCategories(
      title: "Home Services",
      imageUrl: Assets.category7,
      rating: 4,
    ),
    const ServiceCategories(
      title: "Electronics",
      imageUrl: Assets.category8,
      rating: 4,
    ),
    const ServiceCategories(
      title: "Creative",
      imageUrl: Assets.category9,
      rating: 4,
    ),
    const ServiceCategories(
      title: "Engineering",
      imageUrl: Assets.category10,
      rating: 4,
    ),
    const ServiceCategories(
      title: "Logistic",
      imageUrl: Assets.category11,
      rating: 4,
    ),
    const ServiceCategories(
      title: "Electrical",
      imageUrl: Assets.category12,
      rating: 4,
    ),
  ];

  final List<Professionals> _professionals = [
    Professionals(
      title: "Seun Aba",
      designation: "Plumber",
      imageUrl: Assets.professionalImage,
      rating: 5,
    ),
    Professionals(
      title: "Seun Aba",
      designation: "Plumber",
      imageUrl: Assets.professionalImage,
      rating: 5,
    ),
    Professionals(
      title: "Seun Aba",
      designation: "Plumber",
      imageUrl: Assets.professionalImage,
      rating: 5,
    ),
    Professionals(
      title: "Seun Aba",
      designation: "Plumber",
      imageUrl: Assets.professionalImage,
      rating: 5,
    ),
    Professionals(
      title: "Seun Aba",
      designation: "Plumber",
      imageUrl: Assets.professionalImage,
      rating: 5,
    ),
    Professionals(
      title: "Seun Aba",
      designation: "Plumber",
      imageUrl: Assets.professionalImage,
      rating: 5,
    ),
    Professionals(
      title: "Seun Aba",
      designation: "Plumber",
      imageUrl: Assets.professionalImage,
      rating: 5,
    ),
    Professionals(
      title: "Seun Aba",
      designation: "Plumber",
      imageUrl: Assets.professionalImage,
      rating: 5,
    ),
    Professionals(
      title: "Seun Aba",
      designation: "Plumber",
      imageUrl: Assets.professionalImage,
      rating: 5,
    ),
    Professionals(
      title: "Seun Aba",
      designation: "Plumber",
      imageUrl: Assets.professionalImage,
      rating: 5,
    ),
    Professionals(
      title: "Seun Aba",
      designation: "Plumber",
      imageUrl: Assets.professionalImage,
      rating: 5,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateAppBarStatus);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateAppBarStatus);
    _scrollController.dispose();
    super.dispose();
  }

  void _updateAppBarStatus() {
    setState(() {
      _isAppBarSticky = _scrollController.offset > 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600;

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: _isAppBarSticky ? (isSmallScreen ? 100 : 130) : 0,
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!_isAppBarSticky) BrosDAppBar(isSticky: false),
                    HeroSection(),
                    ServiceCategoriesGrid(categories: _serviceCategories),
                    ProfessionalsCarousel(
                      professionals: _professionals,
                      title: "Top Bros-D Professionals",
                    ),
                    BrosDFooter(),
                  ],
                ),
              ),
            ],
          ),
          if (_isAppBarSticky)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AnimatedOpacity(
                opacity: _isAppBarSticky ? 1.0 : 0.0,
                duration: Duration(milliseconds: 200),
                child: BrosDAppBar(isSticky: true),
              ),
            ),
        ],
      ),
    );
  }
}
