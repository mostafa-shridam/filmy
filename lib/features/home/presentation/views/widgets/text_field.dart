import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'main_view_body.dart';

class SearchTextField extends ConsumerStatefulWidget {
  const SearchTextField(
      {super.key, required this.deviceHeight, required this.deviceWidth});
  final double deviceHeight;
  final double deviceWidth;

  @override
  ConsumerState<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends ConsumerState<SearchTextField> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const border = InputBorder.none;
    return SizedBox(
      height: widget.deviceHeight * 0.05,
      width: widget.deviceWidth * 0.50,
      child: TextField(
        controller: controller,
        onChanged: (value) {
          ref
              .read(mainViewDataControllerProvider.notifier)
              .searchMovie(searchText: value);
        },
        decoration: const InputDecoration(
            filled: false,
            hintText: 'Search...',
            focusedBorder: border,
            border: border,
            prefixIcon: Icon(
              Icons.search,
              color: Colors.white60,
            )),
        cursorColor: Colors.white,
        onSubmitted: (value) {
          ref
              .read(mainViewDataControllerProvider.notifier)
              .searchMovie(searchText: value);
        },
        style: const TextStyle(
          color: Colors.white54,
        ),
      ),
    );
  }
}
