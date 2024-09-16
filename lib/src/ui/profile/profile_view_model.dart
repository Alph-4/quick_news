import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_news/src/data/local/model/local_user.dart';

final profileViewModelProvider = Provider((ref) => ProfileViewModel());

class ProfileViewModel {
  Future<void> saveProfile({
    required String displayName,
    required double initialAccountSize,
    File? imageFile,
  }) async {
    try {
      LocalUser().displayName = displayName;
      if (imageFile != null) {
        LocalUser().profileImageUrl = imageFile.path;
      }
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }
}
