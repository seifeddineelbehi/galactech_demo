import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_template/model/game_model.dart';
import 'package:flutter_template/utils/palette.dart';
import 'package:flutter_template/utils/size_config.dart';
import 'package:flutter_template/viewModel/games_view_model.dart';
import 'package:flutter_template/views/pages/Authentication/login_view.dart';
import 'package:flutter_template/views/pages/favorites/favorites_view.dart';
import 'package:flutter_template/views/pages/home/widgets/games_list_widget.dart';
import 'package:flutter_template/views/widgets/custom_animated_widget.dart';
import 'package:flutter_template/views/widgets/profile_custom_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    Key? key,
    required this.games,
  }) : super(key: key);
  final List<GameModel> games;
  static const String id = 'Home_view';
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<GameModel> topGames = [];
  List<GameModel> popularGames = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    for (int i = 0; i < (widget.games.length / 2).round(); i++) topGames.add(widget.games[i]);
    for (int i = (widget.games.length / 2).round(); i < widget.games.length; i++) popularGames.add(widget.games[i]);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Palette.SecondaryColor,
        key: _scaffoldKey,
        drawer: _drawer(context),
        body: Container(
          height: SizeConfig.safeBlockVertical * 100,
          width: SizeConfig.safeBlockHorizontal * 100,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Palette.PrimaryColor,
                Palette.SecondaryColor,
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: SizeConfig.safeBlockVertical * 2),
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomAnimatedWidget(
                        left: SizeConfig.safeBlockHorizontal * 3,
                        child: IconButton(
                          icon: SvgPicture.asset(
                            "assets/images/burger_icon.svg",
                            color: Palette.buttonColor,
                            width: SizeConfig.kDefaultSize * 7,
                          ),
                          onPressed: () {
                            _scaffoldKey.currentState?.openDrawer();
                          },
                        ),
                      ),
                      CustomAnimatedWidget(
                        right: SizeConfig.safeBlockHorizontal * 3,
                        child: IconButton(
                          icon: Icon(
                            FontAwesomeIcons.solidHeart,
                            color: Palette.buttonColor,
                            size: SizeConfig.kDefaultSize * 7,
                          ),
                          onPressed: () async {
                            List<GameModel> games = await context.read<GamesViewModel>().favoriteGames;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FavoritesView(games: games),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 2,
                  ),
                  CustomAnimatedWidget(
                    top: 20,
                    left: SizeConfig.safeBlockHorizontal * 3,
                    child: Text(
                      "Welcome To our Game Store",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: SizeConfig.kDefaultSize * 10,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  _topGamesWidget(),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 2,
                  ),
                  _popularGamesWidget(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Drawer _drawer(BuildContext context) {
    return Drawer(
      backgroundColor: Palette.SecondaryColor,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 2),
            child: ProfileCustomButton(
              text: "Sign Out",
              Icon: "assets/svgs/log_out.svg",
              onTap: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    backgroundColor: Palette.PrimaryColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    title: Text(
                      'Do you want to exit?',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w600,
                        fontSize: SizeConfig.kDefaultSize * 5,
                      ),
                    ),
                    content: Text(
                      'We hate to see you leave...',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w400,
                        fontSize: SizeConfig.kDefaultSize * 4,
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: Text(
                          'No',
                          style: GoogleFonts.poppins(
                            color: const Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w500,
                            fontSize: SizeConfig.kDefaultSize * 4,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          SharedPreferences preferences = await SharedPreferences.getInstance();
                          await preferences.clear();
                          Navigator.pushReplacementNamed(
                            context,
                            LoginView.id,
                          );
                        },
                        child: Text(
                          'Yes',
                          style: GoogleFonts.poppins(
                            color: const Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w500,
                            fontSize: SizeConfig.kDefaultSize * 4,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Column _popularGamesWidget() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.safeBlockHorizontal * 3,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CustomAnimatedWidget(
                top: 20,
                child: Text(
                  "Popular Games",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: SizeConfig.kDefaultSize * 7,
                  ),
                ),
              ),
            ],
          ),
        ),
        GamesList(games: popularGames),
      ],
    );
  }

  Column _topGamesWidget() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.safeBlockHorizontal * 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CustomAnimatedWidget(
                top: 20,
                child: Text(
                  "Top Games",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: SizeConfig.kDefaultSize * 7,
                  ),
                ),
              ),
            ],
          ),
        ),
        GamesList(games: topGames),
      ],
    );
  }
}
