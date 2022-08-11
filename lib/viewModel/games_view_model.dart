import 'package:flutter/cupertino.dart';
import 'package:flutter_template/model/game_model.dart';
import 'package:flutter_template/services/games_services.dart';
import 'package:flutter_template/utils/apis.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

abstract class ConstatRepository {
  getGames();
}

class GamesViewModel with ChangeNotifier implements ConstatRepository {
  bool? _loading = false;
  Object? _responseData;
  List<GameModel> favoriteGames = [];

  setLoading(bool type) {
    _loading = type;
    notifyListeners();
  }

  setFavoriteGames(GameModel game) {
    favoriteGames.add(game);
    print(favoriteGames);
    notifyListeners();
  }

  removeFromFavorite(GameModel game) {
    List<GameModel> games = [];
    favoriteGames.forEach((gameElement) {
      if (gameElement.background_image != game.background_image) {
        games.add(gameElement);
      }
    });
    favoriteGames = games;
    notifyListeners();
  }

  bool existInFavorite(GameModel game) {
    bool value = false;
    favoriteGames.forEach((gameElement) {
      if (gameElement.background_image == game.background_image) {
        value = true;
      }
    });
    return value;
  }

  setResponseData(Object responseData) {
    _responseData = responseData;
    notifyListeners();
  }

  bool get Loading {
    return _loading!;
  }

  Object? get ResponseData {
    return _responseData;
  }

  List<GameModel>? get FavoriteGames {
    return favoriteGames;
  }

  @override
  getGames() async {
    setLoading(true);
    var games = await GamesServices.GetGames(endpoint: URL);
    setResponseData(games!);
    setLoading(false);
  }
}
