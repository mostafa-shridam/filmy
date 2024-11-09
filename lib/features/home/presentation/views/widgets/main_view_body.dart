import 'package:filmy/features/home/presentation/views/widgets/foreground_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/controller/main_view_controller.dart';
import '../../../../../core/models/main_view_model.dart';
import 'background_widget.dart';

final mainViewDataControllerProvider =
    StateNotifierProvider<MainViewController, MainViewDataModel>(
        (ref) => MainViewController());

// ignore: must_be_immutable
class MainViewBody extends ConsumerWidget {
  const MainViewBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    MainViewController mainViewController = ref.watch(
      mainViewDataControllerProvider.notifier,
    );
    MainViewDataModel mainViewDataModel =
        ref.watch(mainViewDataControllerProvider);

    return Stack(
      alignment: Alignment.center,
      children: [
        BackgroundWidget(
          deviceHeight: deviceHeight,
          deviceWidth: deviceWidth,
        ),
        ForegroundWidget(
          deviceWidth: deviceWidth,
          deviceHeight: deviceHeight,
          mainViewDataModel: mainViewDataModel, mainViewController: mainViewController,
        ),
      ],
    );
  }
}
