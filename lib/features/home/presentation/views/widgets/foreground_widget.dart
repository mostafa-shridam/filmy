import 'package:filmy/core/controller/main_view_controller.dart';
import 'package:filmy/features/home/presentation/views/widgets/search_category.dart';
import 'package:filmy/features/home/presentation/views/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/models/main_view_model.dart';
import 'main_view_body.dart';
import 'movie_list_view.dart';

class ForegroundWidget extends StatelessWidget {
  const ForegroundWidget(
      {super.key,
      required this.deviceHeight,
      required this.deviceWidth,
      required this.mainViewDataModel,
      required this.mainViewController});
  final double deviceHeight;
  final double deviceWidth;
  final MainViewDataModel mainViewDataModel;
  final MainViewController mainViewController;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: EdgeInsets.fromLTRB(0, deviceHeight * 0.02, 0, 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: deviceHeight * 0.04,
            ),
            TopBarWidget(
              deviceHeight: deviceHeight,
              deviceWidth: deviceWidth,
              mainViewDataModel: mainViewDataModel,
              mainViewController: mainViewController,
            ),
            SizedBox(
              height: deviceHeight * 0.01,
            ),
            MovieListView(
              deviceHeight: deviceHeight,
              deviceWidth: deviceWidth,
              mainViewDataModel: mainViewDataModel,
            ),
          ],
        ),
      ),
    );
  }
}

class TopBarWidget extends StatelessWidget {
  const TopBarWidget(
      {super.key,
      required this.deviceHeight,
      required this.deviceWidth,
      required this.mainViewDataModel,
      required this.mainViewController});
  final double deviceHeight;
  final double deviceWidth;
  final MainViewDataModel mainViewDataModel;
  final MainViewController mainViewController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: deviceHeight * 0.08,
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SearchTextField(
            deviceHeight: deviceHeight,
            deviceWidth: deviceWidth,
          ),
          SelectCategoryWidget(
            mainViewDataModel: mainViewDataModel,
            mainViewController: mainViewController,
          ),
        ],
      ),
    );
  }
}

class SelectCategoryWidget extends ConsumerWidget {
  const SelectCategoryWidget(
      {super.key,
      required this.mainViewDataModel,
      required this.mainViewController});
  final MainViewDataModel mainViewDataModel;
  final MainViewController mainViewController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DropdownButton(
      value: ref.watch(mainViewDataControllerProvider).searchCategory,
      dropdownColor: const Color(0xDD202020),
      borderRadius: BorderRadius.circular(10),
      hint: Text(
        ref.watch(mainViewDataControllerProvider).searchCategory,
        style: TextStyle(color: Colors.white),
      ),
      style: TextStyle(color: Colors.white),
      items: [
        DropdownMenuItem(
          value: SearchCategory.popular,
          onTap: () =>
              ref.watch(mainViewDataControllerProvider.notifier).getMovies(
                    searchCategory: SearchCategory.popular,
                  ),
          child: Text(SearchCategory.popular),
        ),
        DropdownMenuItem(
          value: SearchCategory.upcoming,
          onTap: () =>
              ref.watch(mainViewDataControllerProvider.notifier).getMovies(
                    searchCategory: SearchCategory.upcoming,
                  ),
          child: Text(SearchCategory.upcoming),
        ),
      ],
      onChanged: (value) => mainViewController.getMovies(
        searchCategory: value.toString(),
      ),
    );
  }
}
