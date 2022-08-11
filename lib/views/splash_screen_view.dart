import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/model/game_model.dart';
import 'package:flutter_template/utils/utils.dart';
import 'package:flutter_template/viewModel/games_view_model.dart';
import 'package:flutter_template/views/views.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash_screen_view';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(microseconds: 0), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey("connected")) {
        await context.read<GamesViewModel>().getGames();
        var response = context.read<GamesViewModel>().ResponseData;
        if (response is List<GameModel>) {
          print(response);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeView(games: response),
            ),
          );
        } else {
          Navigator.pushReplacementNamed(
            context,
            ErrorView.id,
          );
        }
      } else {
        Navigator.pushReplacementNamed(
          context,
          LoginView.id,
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      color: Palette.PageMainColor,
      child: const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}
