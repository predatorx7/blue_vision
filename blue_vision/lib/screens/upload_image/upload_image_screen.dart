import 'package:blue_vision/widgets/responsive/centered.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'upload_image_provider.dart';
import 'upload_image_state.dart';

class _UploadImageScreenNavigation {
  final route = GoRoute(
    path: 'upload_image',
    builder: (context, state) {
      return const UploadImageScreen();
    },
  );

  // add other ways create a path for navigating to this screen.
}

class UploadImageScreen extends ConsumerWidget {
  const UploadImageScreen({super.key});

  static final navigation = _UploadImageScreenNavigation();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<UploadImageScreenState>(
      uploadImageControllerProvider,
      (prev, next) {
        // do something
      },
    );

    final screenState = ref.watch(uploadImageControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(screenState.toString()),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 20.0,
        ),
        child: CenteredConstraintBox(
          maxWidth: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: SizedBox.square(
                      dimension: constraints.maxWidth,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 12,
              ),
              ElevatedButton(
                onPressed: () {
                  final controller =
                      ref.read(uploadImageControllerProvider.notifier);
                  controller.uploadImage();
                },
                child: const Text('Upload Image'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
