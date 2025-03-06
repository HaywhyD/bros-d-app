import 'package:bros_d_app/ui/screens/home/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

final routes = GoRouter(
  initialLocation: HomeScreen.route,
  routes: [
    GoRoute(
      name: HomeScreen.name,
      path: HomeScreen.route,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          CupertinoPage<void>(
        child: const HomeScreen(),
        key: state.pageKey,
      ),
    ),
  ],
);
