import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_template/model/game_model.dart';
import 'package:flutter_template/utils/palette.dart';
import 'package:flutter_template/utils/size_config.dart';
import 'package:flutter_template/views/pages/detail/widgets/heart._widget.dart';
import 'package:flutter_template/views/widgets/custom_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailView extends StatefulWidget {
  const DetailView({Key? key, required this.game}) : super(key: key);
  final GameModel game;
  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Palette.PrimaryColor,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Stack(
              children: [
                Hero(
                  tag: widget.game.background_image!,
                  child: CachedNetworkImage(
                    imageUrl: widget.game.background_image!,
                    fit: BoxFit.fill,
                    height: SizeConfig.safeBlockVertical * 55,
                    width: SizeConfig.safeBlockHorizontal * 100,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: SizeConfig.kDefaultSize * 15,
                            width: SizeConfig.kDefaultSize * 15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(SizeConfig.kDefaultSize * 50),
                              color: Palette.SecondaryColor.withOpacity(0.6),
                            ),
                            child: Icon(
                              FontAwesomeIcons.arrowLeft,
                              color: Palette.buttonColor,
                              size: SizeConfig.kDefaultSize * 7,
                            ),
                          ),
                        ),
                        Container(
                          height: SizeConfig.kDefaultSize * 15,
                          width: SizeConfig.kDefaultSize * 15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(SizeConfig.kDefaultSize * 50),
                            color: Palette.SecondaryColor.withOpacity(0.6),
                          ),
                          child: Center(
                            child: HeartWidget(game: widget.game),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 45),
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Palette.PrimaryColor,
                    Palette.SecondaryColor,
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(SizeConfig.kDefaultSize * 12),
                  topRight: Radius.circular(SizeConfig.kDefaultSize * 12),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(SizeConfig.kDefaultSize * 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      child: Container(
                        width: SizeConfig.safeBlockHorizontal * 30,
                        height: SizeConfig.safeBlockVertical * 1,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 4,
                    ),
                    Text(
                      widget.game.name!,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: SizeConfig.kDefaultSize * 7,
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 4,
                    ),
                    Row(
                      children: [
                        Text(
                          "Rating: ",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: SizeConfig.kDefaultSize * 5,
                          ),
                        ),
                        Text(
                          widget.game.rating.toString(),
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: SizeConfig.kDefaultSize * 5,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 4,
                    ),
                    Row(
                      children: [
                        Text(
                          "Released Date: ",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: SizeConfig.kDefaultSize * 5,
                          ),
                        ),
                        Text(
                          widget.game.released!,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: SizeConfig.kDefaultSize * 5,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 4,
                    ),
                    Text(
                      "Status: ",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: SizeConfig.kDefaultSize * 5,
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 2,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: SizeConfig.safeBlockHorizontal * 4),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Owned By: ",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: SizeConfig.kDefaultSize * 5,
                                ),
                              ),
                              Text(
                                widget.game.added_by_status!.owned.toString(),
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: SizeConfig.kDefaultSize * 5,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: SizeConfig.safeBlockVertical * 2,
                          ),
                          Row(
                            children: [
                              Text(
                                "Beaten By: ",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: SizeConfig.kDefaultSize * 5,
                                ),
                              ),
                              Text(
                                widget.game.added_by_status!.beaten.toString(),
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: SizeConfig.kDefaultSize * 5,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: SizeConfig.safeBlockVertical * 2,
                          ),
                          Row(
                            children: [
                              Text(
                                "Currently Playing By: ",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: SizeConfig.kDefaultSize * 5,
                                ),
                              ),
                              Text(
                                widget.game.added_by_status!.playing.toString(),
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: SizeConfig.kDefaultSize * 5,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: SizeConfig.safeBlockVertical * 2,
                          ),
                          Row(
                            children: [
                              Text(
                                "Dropped By: ",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: SizeConfig.kDefaultSize * 5,
                                ),
                              ),
                              Text(
                                widget.game.added_by_status!.dropped.toString(),
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: SizeConfig.kDefaultSize * 5,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: SizeConfig.safeBlockVertical * 2,
                          ),
                          Row(
                            children: [
                              Text(
                                "To play By: ",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: SizeConfig.kDefaultSize * 5,
                                ),
                              ),
                              Text(
                                widget.game.added_by_status!.toplay.toString(),
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: SizeConfig.kDefaultSize * 5,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: SizeConfig.safeBlockVertical * 4,
                          ),
                        ],
                      ),
                    ),
                    CustomButton(
                      onPressed: () async {},
                      child: Text(
                        "Add to Cart",
                        style: GoogleFonts.poppins(
                          color: const Color(0xFFFFFFFF),
                          fontWeight: FontWeight.w700,
                          fontSize: SizeConfig.kDefaultSize * 5,
                        ),
                      ),
                      height: SizeConfig.blockSizeVertical * 10,
                      fontSize: SizeConfig.kDefaultSize * 5.5,
                      primary: Palette.buttonColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
