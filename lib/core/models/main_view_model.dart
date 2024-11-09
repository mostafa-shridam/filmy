import 'package:filmy/core/models/movie_model.dart';
import 'package:filmy/features/home/presentation/views/widgets/search_category.dart';

class MainViewDataModel {
  final List<MovieModel> movieModel;
  final String searchCategory;
  final String searchText;
  final int page;

  MainViewDataModel({
    required this.movieModel,
    required this.searchCategory,
    required this.searchText,
    required this.page,
  });
  MainViewDataModel.intial()
      : movieModel = [],
        searchCategory = SearchCategory.popular,
        searchText = "",
        page = 1;

  MainViewDataModel copyWith({
    List<MovieModel>? movieModel,
    String? searchCategory,
    String? searchText,
    int? page,
  }) {
    return MainViewDataModel(
      movieModel: movieModel ?? this.movieModel,
      searchCategory: searchCategory ?? this.searchCategory,
      searchText: searchText ?? this.searchText,
      page: page ?? this.page,
    );
  }
}
