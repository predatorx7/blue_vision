import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'upload_image_controller.dart';
import 'upload_image_state.dart';

final uploadImageControllerProvider = StateNotifierProvider.autoDispose<
    UploadImageController, UploadImageScreenState>((ref) {
  return UploadImageController(ref);
});
