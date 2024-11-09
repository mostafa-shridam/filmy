import 'package:filmy/features/home/presentation/views/widgets/main_view_body.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  static const String routeName = 'home';
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      resizeToAvoidBottomInset: false,
      body: MainViewBody(),
    );
  }
}
