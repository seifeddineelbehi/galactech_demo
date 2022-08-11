import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/model/game_model.dart';
import 'package:flutter_template/utils/palette.dart';
import 'package:flutter_template/utils/size_config.dart';
import 'package:flutter_template/views/pages/detail/detail_view.dart';
import 'package:google_fonts/google_fonts.dart';

class GamesList extends StatefulWidget {
  const GamesList({
    Key? key,
    required this.games,
  }) : super(key: key);
  final List<GameModel> games;

  @override
  State<GamesList> createState() => _GamesListState();
}

class _GamesListState extends State<GamesList> {
  GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<GameModel> games = [];
  final Tween<Offset> _offset = Tween(begin: const Offset(1, 0), end: const Offset(0, 0));
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _addGames();
    });
    super.initState();
  }

  void _addGames() {
    Future ft = Future(() {});
    for (int i = 0; i < (widget.games.length).round(); i++) {
      ft = ft.then((data) {
        return Future.delayed(const Duration(milliseconds: 500), () {
          games.add(widget.games[i]);
          _listKey.currentState?.insertItem(games.length - 1);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 2),
      child: SizedBox(
        height: SizeConfig.safeBlockVertical * 32,
        child: AnimatedList(
          key: _listKey,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.safeBlockHorizontal * 4.5,
            vertical: SizeConfig.safeBlockVertical * 1,
          ),
          initialItemCount: games.length,
          itemBuilder: (context, index, animation) => SlideTransition(
            position: animation.drive(_offset),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailView(game: widget.games[index]),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: SizeConfig.safeBlockHorizontal * 2),
                child: Container(
                  width: SizeConfig.safeBlockHorizontal * 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Palette.SecondaryColor.withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        top: 0,
                        right: 0,
                        left: 0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Hero(
                            tag: widget.games[index].background_image!,
                            child: CachedNetworkImage(
                              imageUrl: widget.games[index].background_image!,
                              fit: BoxFit.fill,
                              placeholder: (context, url) => Center(child: const CircularProgressIndicator()),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: const Alignment(0.0, -1.0),
                              end: const Alignment(0.0, 0.6),
                              colors: [
                                Colors.black.withOpacity(0.0),
                                Colors.black.withOpacity(0.0),
                                Colors.black.withOpacity(0.0),
                                Colors.black.withOpacity(0.4),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          height: SizeConfig.safeBlockVertical * 32,
                          width: SizeConfig.safeBlockHorizontal * 80,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: SizeConfig.safeBlockHorizontal * 2),
                          child: SizedBox(
                            height: SizeConfig.safeBlockVertical * 8,
                            width: SizeConfig.safeBlockHorizontal * 75,
                            child: Text(
                              widget.games[index].name!,
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: SizeConfig.kDefaultSize * 5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ), // ListTile
        ),
      ),
    );
  }
}
