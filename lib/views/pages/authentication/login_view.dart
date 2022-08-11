import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_template/model/game_model.dart';
import 'package:flutter_template/utils/palette.dart';
import 'package:flutter_template/utils/size_config.dart';
import 'package:flutter_template/viewModel/games_view_model.dart';
import 'package:flutter_template/views/views.dart';
import 'package:flutter_template/views/widgets/custom_button.dart';
import 'package:flutter_template/views/widgets/custom_text_form_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  static const String id = 'Login_Participated_View';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  var _password = "";
  var _email = "";
  bool load = false;

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    print(arguments['role']);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Palette.PageMainColor,
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.safeBlockHorizontal * 5),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: SizedBox(
                  height: SizeConfig.safeBlockVertical * 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: SizeConfig.safeBlockVertical * 2,
                      ),
                      Container(
                        height: SizeConfig.safeBlockVertical * 25,
                        child: Image.asset(
                          "assets/images/logo.png",
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            "LOGIN",
                            style: GoogleFonts.poppins(
                              color: const Color(0xFFFFFFFF),
                              fontWeight: FontWeight.w700,
                              fontSize: SizeConfig.kDefaultSize * 6,
                            ),
                          ),
                          Text(
                            "TO CONTINUE",
                            style: GoogleFonts.poppins(
                              color: const Color(0xFFFFFFFF),
                              fontWeight: FontWeight.w700,
                              fontSize: SizeConfig.kDefaultSize * 6,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          CustomTextFormField(
                            textColor: Colors.white,
                            hintText: "Email",
                            textInputType: TextInputType.emailAddress,
                            iconData: Icons.mail,
                            textInputAction: TextInputAction.next,
                            underLineColor: Palette.buttonColor,
                            iconColor: Palette.buttonColor,
                            withText: false,
                            onSaved: (String? value) {
                              setState(() {
                                _email = value.toString();
                              });
                            },
                            onValidate: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Email shouldn't be empty";
                              } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                                return "Email format is invalid";
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(
                            height: SizeConfig.safeBlockVertical * 4,
                          ),
                          CustomTextFormField(
                            textColor: Colors.white,
                            obscureText: true,
                            textInputAction: TextInputAction.done,
                            hintText: "Password",
                            iconData: Icons.lock,
                            underLineColor: Palette.buttonColor,
                            iconColor: Palette.buttonColor,
                            withText: false,
                            onSaved: (String? value) {
                              setState(() {
                                _password = value.toString();
                              });
                            },
                            onValidate: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Password shouldn't be empty";
                              } else if (value.length < 5) {
                                return "Password must contain at least 5 characters";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          CustomButton(
                            onPressed: !context.watch<GamesViewModel>().Loading
                                ? () async {
                                    FocusManager.instance.primaryFocus?.unfocus();
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();

                                      await context.read<GamesViewModel>().getGames();
                                      var response = context.read<GamesViewModel>().ResponseData;
                                      if (response is List<GameModel>) {
                                        SharedPreferences prefs = await SharedPreferences.getInstance();
                                        prefs.setString("connected", "true");
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => HomeView(games: response),
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text('Something Went Wrong'),
                                          ),
                                        );
                                      }
                                    }
                                  }
                                : () {},
                            primary: Palette.buttonColor,
                            height: SizeConfig.blockSizeVertical * 10,
                            fontSize: SizeConfig.kDefaultSize * 5.5,
                            child: !context.watch<GamesViewModel>().Loading
                                ? Text(
                                    "Login",
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xFFFFFFFF),
                                      fontWeight: FontWeight.w700,
                                      fontSize: SizeConfig.kDefaultSize * 5,
                                    ),
                                  )
                                : CircularProgressIndicator(),
                          ),
                          SizedBox(
                            height: SizeConfig.safeBlockVertical * 2,
                          ),
                          Container(
                            width: SizeConfig.safeBlockHorizontal * 30,
                            child: const Divider(
                              color: Palette.textSecondaryColor,
                              thickness: 1.2,
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.safeBlockVertical * 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "don't have an account? ",
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFFFFFFFF),
                                  fontWeight: FontWeight.w400,
                                  fontSize: SizeConfig.kDefaultSize * 4,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.pushNamed(
                                    context,
                                    SignUp.id,
                                  );
                                },
                                child: Text(
                                  "Sign Up",
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xFFFFFFFF),
                                    fontWeight: FontWeight.w700,
                                    fontSize: SizeConfig.kDefaultSize * 4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
