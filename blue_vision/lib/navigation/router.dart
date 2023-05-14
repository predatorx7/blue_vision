import 'package:go_router/go_router.dart';

import '../screens/home/home.dart';

final routes = <RouteBase>[
  HomeScreen.navigation.route,
];

final router = GoRouter(
  routes: routes,
);
