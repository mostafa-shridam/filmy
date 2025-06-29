import 'package:video_player/video_player.dart';
import 'package:flutter/foundation.dart';

class VideoPlayerService {
  static VideoPlayerService? _instance;
  static VideoPlayerService get instance =>
      _instance ??= VideoPlayerService._();

  VideoPlayerService._();

  Future<VideoPlayerController?> initializeVideoPlayer({
    required String videoUrl,
    Duration timeout = const Duration(seconds: 30),
  }) async {
    try {
      // Validate URL
      if (videoUrl.isEmpty) {
        throw Exception('Video URL is empty');
      }

      // Create controller with proper configuration
      final controller = VideoPlayerController.networkUrl(
        Uri.parse(videoUrl),
        videoPlayerOptions: VideoPlayerOptions(
          mixWithOthers: false,
          allowBackgroundPlayback: false,
        ),
      );

      // Initialize with timeout
      await controller.initialize().timeout(
        timeout,
        onTimeout: () {
          controller.dispose();
          throw Exception('Video initialization timeout');
        },
      );

      return controller;
    } catch (e) {
      debugPrint('VideoPlayerService: Error initializing video player: $e');
      rethrow;
    }
  }

  Future<void> disposeController(VideoPlayerController? controller) async {
    try {
      if (controller != null) {
        await controller.dispose();
      }
    } catch (e) {
      debugPrint('VideoPlayerService: Error disposing controller: $e');
    }
  }

  String getErrorMessage(dynamic error) {
    final errorString = error.toString().toLowerCase();

    if (errorString.contains('timeout')) {
      return 'انتهت مهلة الاتصال';
    } else if (errorString.contains('network') ||
        errorString.contains('connection')) {
      return 'خطأ في الاتصال بالشبكة';
    } else if (errorString.contains('codec') ||
        errorString.contains('unsupported')) {
      return 'تنسيق الفيديو غير مدعوم';
    } else if (errorString.contains('404') ||
        errorString.contains('not found')) {
      return 'الفيديو غير متاح';
    } else if (errorString.contains('permission')) {
      return 'لا توجد صلاحيات كافية';
    } else if (errorString.contains('format')) {
      return 'تنسيق الفيديو غير صحيح';
    } else {
      return 'حدث خطأ أثناء تشغيل الفيديو';
    }
  }

  bool isVideoUrlValid(String url) {
    if (url.isEmpty) return false;

    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (e) {
      return false;
    }
  }

  Future<bool> checkVideoAvailability(String url) async {
    try {
      final controller = VideoPlayerController.networkUrl(Uri.parse(url));
      await controller.initialize().timeout(const Duration(seconds: 10));
      await controller.dispose();
      return true;
    } catch (e) {
      return false;
    }
  }
}
