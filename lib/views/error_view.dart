import 'package:flutter/material.dart';
import 'package:flutter_template/utils/utils.dart';
import 'package:flutter_template/views/views.dart';
import 'package:flutter_template/views/widgets/custom_button.dart';
import 'package:google_fonts/google_fonts.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({Key? key}) : super(key: key);
  static const String id = 'Error_View';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.PrimaryColor,
      body: Container(
        height: SizeConfig.safeBlockVertical * 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/error_solid.gif",
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: CustomButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    SplashScreen.id,
                  );
                },
                child: Text(
                  "rafraîchir",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: SizeConfig.kDefaultSize * 5,
                  ),
                ),
                height: SizeConfig.blockSizeVertical * 10,
                fontSize: SizeConfig.kDefaultSize * 5.5,
                primary: const Color(0xFFFFFFFF),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
