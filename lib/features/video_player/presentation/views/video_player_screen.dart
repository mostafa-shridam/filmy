import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/services/video_player_service.dart';
import '../../../home/presentation/views/widgets/background_widget.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;
  final String title;
  final String? posterUrl;

  const VideoPlayerScreen({
    super.key,
    required this.videoUrl,
    required this.title,
    this.posterUrl,
  });

  static const String routeName = 'video_player';

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController? _videoPlayerController;
  bool _isLoading = true;
  bool _hasError = false;
  bool _isPlaying = false;
  String _errorMessage = '';
  final VideoPlayerService _videoService = VideoPlayerService.instance;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    try {
      setState(() {
        _isLoading = true;
        _hasError = false;
        _errorMessage = '';
      });

      // Validate video URL
      if (!_videoService.isVideoUrlValid(widget.videoUrl)) {
        throw Exception('Invalid video URL');
      }

      // Dispose previous controller if exists
      await _videoService.disposeController(_videoPlayerController);

      // Initialize new controller using service
      _videoPlayerController = await _videoService.initializeVideoPlayer(
        videoUrl: widget.videoUrl,
        timeout: const Duration(seconds: 30),
      );

      if (_videoPlayerController == null) {
        throw Exception('Failed to initialize video player');
      }

      // Add listener for state changes
      _videoPlayerController!.addListener(() {
        if (mounted) {
          setState(() {
            _isPlaying = _videoPlayerController!.value.isPlaying;
          });
        }
      });

      setState(() {
        _isLoading = false;
      });

      // Auto-play the video
      await _videoPlayerController!.play();
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
        _errorMessage = _videoService.getErrorMessage(e);
      });

      // Log error for debugging
      debugPrint('Video player error: $e');
    }
  }

  @override
  void dispose() {
    _videoService.disposeController(_videoPlayerController);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            BackgroundWidget(
              deviceHeight: MediaQuery.of(context).size.height,
              deviceWidth: MediaQuery.of(context).size.width,
              imageUrl: widget.posterUrl ?? '',
            ),
            Column(
              children: [
                Expanded(
                  child: _isLoading
                      ? const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                color: AppColors.primaryColor,
                              ),
                              SizedBox(height: 16),
                              Text(
                                'جاري تحميل الفيديو...',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        )
                      : _hasError
                          ? _buildErrorWidget()
                          : _buildVideoPlayer(),
                ),
                _buildVideoInfo(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoPlayer() {
    if (_videoPlayerController == null ||
        !_videoPlayerController!.value.isInitialized) {
      return _buildErrorWidget();
    }

    return Center(
      child: AspectRatio(
        aspectRatio: _videoPlayerController!.value.aspectRatio,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Chewie(
              controller: ChewieController(
                videoPlayerController: _videoPlayerController!,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 80,
          ),
          const SizedBox(height: 16),
          Text(
            _errorMessage.isNotEmpty ? _errorMessage : 'لا يمكن تشغيل الفيديو',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            'تأكد من صحة رابط الفيديو',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _initializePlayer,
            icon: const Icon(Icons.refresh),
            label: const Text('إعادة المحاولة'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.info_outline,
                color: Colors.white70,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'معلومات الفيديو',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            widget.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                _isPlaying
                    ? Icons.play_circle_filled
                    : Icons.pause_circle_filled,
                color: AppColors.primaryColor,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                _isPlaying ? 'جاري التشغيل' : 'متوقف مؤقتاً',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
