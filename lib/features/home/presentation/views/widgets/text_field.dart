import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField(
      {super.key, required this.deviceHeight, required this.deviceWidth});
  final double deviceHeight;
  final double deviceWidth;
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    const border = InputBorder.none;
    return SizedBox(
      height: deviceHeight * 0.05,
      width: deviceWidth * 0.50,
      child: TextField(
        controller: controller,
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
        onSubmitted: (value) {},
        style: const TextStyle(
          color: Colors.white54,
        ),
      ),
    );
  }
}
