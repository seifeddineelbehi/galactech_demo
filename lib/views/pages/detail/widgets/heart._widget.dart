import 'package:flutter/material.dart';
import 'package:flutter_template/model/game_model.dart';
import 'package:flutter_template/utils/palette.dart';
import 'package:flutter_template/viewModel/games_view_model.dart';
import 'package:provider/provider.dart';

class HeartWidget extends StatefulWidget {
  const HeartWidget({
    Key? key,
    required this.game,
  }) : super(key: key);
  final GameModel game;
  @override
  _HeartWidgetState createState() => _HeartWidgetState();
}

class _HeartWidgetState extends State<HeartWidget> with SingleTickerProviderStateMixin {
  bool isFav = false;
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _sizeAnimation;
  late Animation<double> _curve;

  addFavoritGame() async {
    print("add ");
    await context.read<GamesViewModel>().setFavoriteGames(widget.game);
  }

  // removeFromFavorite() async {
  //   print("remove ");
  //   await context.read<GamesViewModel>().removeMealFromFavorite(widget.game);
  // }

  @override
  void initState() {
    super.initState();
    isFav = context.read<GamesViewModel>().existInFavorite(widget.game);
    _controller = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );

    _curve = CurvedAnimation(parent: _controller, curve: Curves.slowMiddle);

    _colorAnimation = !isFav
        ? ColorTween(begin: Palette.buttonColor.withOpacity(0.6), end: Palette.buttonColor).animate(_curve)
        : ColorTween(begin: Palette.buttonColor, end: Palette.buttonColor.withOpacity(0.6)).animate(_curve);

    _sizeAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 30, end: 50),
        weight: 50,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 50, end: 30),
        weight: 50,
      ),
    ]).animate(_curve);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          isFav = true;
        });
      }
      if (status == AnimationStatus.dismissed) {
        setState(() {
          isFav = false;
        });
      }
    });
  }

  // dismiss the animation when widgit exits screen
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, _) {
          return IconButton(
            icon: Icon(
              Icons.favorite,
              color: _colorAnimation.value,
              size: _sizeAnimation.value,
            ),
            onPressed: () {
              isFav ? _controller.reverse() : _controller.forward();
              !isFav
                  ? context.read<GamesViewModel>().setFavoriteGames(widget.game)
                  : context.read<GamesViewModel>().removeFromFavorite(widget.game);
            },
          );
        });
  }
}
