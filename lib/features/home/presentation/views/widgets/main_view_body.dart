import 'package:filmy/features/home/presentation/views/widgets/foreground_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/controller/main_view_controller.dart';
import '../../../../../core/models/main_view_model.dart';
import 'background_widget.dart';

final mainViewDataControllerProvider =
    StateNotifierProvider<MainViewController, MainViewDataModel>(
        (ref) => MainViewController());

final selectedMovieBackdropPathProvider = StateProvider<String>((ref) {
  final movieModel = ref.watch(mainViewDataControllerProvider).movieModel;
  return movieModel.isNotEmpty ? movieModel[0].posterUrl() : "";
});

// ignore: must_be_immutable
class MainViewBody extends ConsumerStatefulWidget {
  const MainViewBody({super.key});

  @override
  ConsumerState<MainViewBody> createState() => _MainViewBodyState();
}

class _MainViewBodyState extends ConsumerState<MainViewBody> {
  bool _hasInitialized = false;
  List<String> _lastMovieTitles = [];

  @override
  void initState() {
    super.initState();
    // Ensure first movie is selected after widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _selectFirstMovie();
    });
  }

  void _selectFirstMovie() {
    final mainViewDataModel = ref.read(mainViewDataControllerProvider);
    if (mainViewDataModel.movieModel.isNotEmpty && !_hasInitialized) {
      final firstMovieUrl = mainViewDataModel.movieModel[0].posterUrl();
      ref.read(selectedMovieBackdropPathProvider.notifier).state =
          firstMovieUrl;
      _hasInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    MainViewController mainViewController = ref.watch(
      mainViewDataControllerProvider.notifier,
    );
    MainViewDataModel mainViewDataModel =
        ref.watch(mainViewDataControllerProvider);

    // Get current movie titles to detect list changes
    final currentMovieTitles =
        mainViewDataModel.movieModel.map((m) => m.title).toList();

    // Auto-select first movie only when movie list changes (new category, search reset, etc.)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mainViewDataModel.movieModel.isNotEmpty &&
          !_listsAreEqual(currentMovieTitles, _lastMovieTitles)) {
        final currentSelected = ref.read(selectedMovieBackdropPathProvider);
        final firstMovieUrl = mainViewDataModel.movieModel[0].posterUrl();

        // Only auto-select if no movie is currently selected
        if (currentSelected.isEmpty) {
          ref.read(selectedMovieBackdropPathProvider.notifier).state =
              firstMovieUrl;
        }

        _lastMovieTitles = List.from(currentMovieTitles);
      }
    });

    return Stack(
      alignment: Alignment.center,
      children: [
        BackgroundWidget(
          deviceHeight: deviceHeight,
          deviceWidth: deviceWidth,
          imageUrl: ref.watch(selectedMovieBackdropPathProvider),
        ),
        ForegroundWidget(
          deviceWidth: deviceWidth,
          deviceHeight: deviceHeight,
          mainViewDataModel: mainViewDataModel,
          mainViewController: mainViewController,
        ),
      ],
    );
  }

  bool _listsAreEqual(List<String> list1, List<String> list2) {
    if (list1.length != list2.length) return false;
    for (int i = 0; i < list1.length; i++) {
      if (list1[i] != list2[i]) return false;
    }
    return true;
  }
}
