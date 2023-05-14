import 'package:blue_vision/screens/upload_image/upload_image.dart';
import 'package:blue_vision/navigation/navigation_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'home_provider.dart';
import 'home_state.dart';

// TODO: Add `HomeScreen.navigation` in your `GoRouter`'s routes
class _HomeScreenNavigation {
  final route = GoRoute(
    path: '/',
    builder: (context, state) {
      return HomeScreen();
    },
    routes: [
      UploadImageScreen.navigation.route,
    ],
  );

  // add other ways create a path for navigating to this screen.
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static final navigation = _HomeScreenNavigation();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<HomeScreenState>(
      homeControllerProvider,
      (prev, next) {
        // do something
      },
    );

    final screenState = ref.watch(homeControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(screenState.toString()),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.goRelative(UploadImageScreen.navigation.route.path);
          },
          child: const Text('Take a picture'),
        ),
      ),
    );
  }
}
