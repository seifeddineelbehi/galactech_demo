import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_template/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileCustomButton extends StatelessWidget {
  const ProfileCustomButton({
    Key? key,
    required this.onTap,
    required this.Icon,
    required this.text,
  }) : super(key: key);

  final VoidCallback onTap;
  final String Icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.safeBlockHorizontal * 4, vertical: SizeConfig.safeBlockVertical * 0.4),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.safeBlockHorizontal * 3),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Palette.buttonColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Palette.buttonColor.withOpacity(0.3),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.safeBlockVertical * 2, horizontal: SizeConfig.safeBlockHorizontal * 3),
                      child: SvgPicture.asset(
                        Icon,
                        height: SizeConfig.kDefaultSize * 5,
                        width: SizeConfig.kDefaultSize * 5,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.safeBlockHorizontal * 4,
                  ),
                  Text(
                    text,
                    style: GoogleFonts.poppins(
                      color: Palette.buttonColor,
                      fontWeight: FontWeight.w600,
                      fontSize: SizeConfig.kDefaultSize * 4.5,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 1.5,
            ),
            const Divider(
              thickness: 1.5,
            )
          ],
        ),
      ),
    );
  }
}
