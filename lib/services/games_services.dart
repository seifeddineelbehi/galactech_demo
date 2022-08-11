import 'package:flutter_template/model/add_by_status_model.dart';
import 'package:flutter_template/model/game_model.dart';
import 'package:flutter_template/utils/apis.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class GamesServices {
  static Future<Object?> GetGames({
    required String endpoint,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    Map<String, String> requestHeaders = {
      HttpHeaders.contentTypeHeader: " application/json",
      'X-RapidAPI-Key': "a263ebd6f3msha42237dde431ad6p15936fjsn7fe03c5d65dd",
      'X-RapidAPI-Host': "rawg-video-games-database.p.rapidapi.com",
    };
    final Map<String, String> _queryParameters = <String, String>{
      'key': KEY,
    };
    //Uri uri = Uri.http(endpoint, GETGAMES, _queryParameters);
    Uri uri = Uri.parse('https://rawg-video-games-database.p.rapidapi.com/games?key=a48b175fb4ef4b25bd63ef1c398ecee9');
    print(uri.path);
    try {
      var response = await http.get(uri, headers: requestHeaders);
      print("aaaaaaaaaaaaaaaaaaaaaaaa");

      if (response.statusCode == 200) {
        List<GameModel> games = [];
        List<dynamic> returnGames = json.decode(response.body)['results'];

        returnGames.forEach((game) {
          print(game['added_by_status']['dropped']);
          AddByStatusModel addByStatusModel = AddByStatusModel(
            beaten: game['added_by_status']['beaten'],
            dropped: game['added_by_status']['dropped'],
            owned: game['added_by_status']['owned'],
            playing: game['added_by_status']['playing'],
            toplay: game['added_by_status']['toplay'],
            yet: game['added_by_status']['yet'],
          );
          GameModel gameModel = GameModel(
            background_image: game['background_image'],
            name: game['name'],
            rating: game['rating'],
            released: game['released'],
            added_by_status: addByStatusModel,
          );
          games.add(gameModel);
        });
        return games;
      } else {
        return "Failure";
      }
      // }
    } catch (exception) {
      return "Failure";
    }
  }
}
