import 'package:flutter_template/viewModel/games_view_model.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future init() async {
  GetIt.I.registerLazySingleton(() => GamesViewModel());
}
