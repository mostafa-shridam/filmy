import 'package:filmy/core/controller/main_view_controller.dart';
import 'package:filmy/features/home/presentation/views/widgets/main_view_body.dart';
import 'package:filmy/features/home/presentation/views/widgets/search_category.dart';
import 'package:filmy/features/home/presentation/views/widgets/text_field.dart';
import 'package:flutter/material.dart';

import '../../../../../core/models/main_view_model.dart';
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

class SelectCategoryWidget extends StatefulWidget {
  const SelectCategoryWidget(
      {super.key,
      required this.mainViewDataModel,
      required this.mainViewController});
  final MainViewDataModel mainViewDataModel;
  final MainViewController mainViewController;

  @override
  State<SelectCategoryWidget> createState() => _SelectCategoryWidgetState();
}

class _SelectCategoryWidgetState extends State<SelectCategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      onChanged: (value) => value.toString().isNotEmpty
          ? widget.mainViewController.getMovies(
              searchCategory: value.toString(),
            )
          : null,
      value: widget.mainViewDataModel.searchCategory,
      dropdownColor: Colors.black38,
      onTap: () => widget.mainViewController.getMovies(
        searchCategory: widget.mainViewDataModel.searchCategory,
      ),
      items: const [
        DropdownMenuItem(
          value: SearchCategory.popular,
          enabled: false,
          child: Text(
            SearchCategory.popular,
            style: TextStyle(color: Colors.white),
          ),
        ),
        DropdownMenuItem(
          value: SearchCategory.upcoming,
          enabled: false,
          child: Text(
            SearchCategory.upcoming,
            style: TextStyle(color: Colors.white),
          ),
        ),
        DropdownMenuItem(
          value: SearchCategory.none,
          enabled: false,
          child: Text(SearchCategory.none),
        ),
      ],
    );
  }
}
