import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'upload_image_state.dart';

class UploadImageController extends StateNotifier<UploadImageScreenState> {
  UploadImageController(this._ref): super(const UploadImageScreenState());

  final Ref _ref;

  void uploadImage() {
    // TODO: implement
  }
}
