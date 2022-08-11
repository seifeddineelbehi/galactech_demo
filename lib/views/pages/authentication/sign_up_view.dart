import 'package:flutter/material.dart';
import 'package:flutter_template/model/game_model.dart';
import 'package:flutter_template/utils/palette.dart';
import 'package:flutter_template/utils/size_config.dart';
import 'package:flutter_template/viewModel/games_view_model.dart';
import 'package:flutter_template/views/pages/Authentication/login_view.dart';
import 'package:flutter_template/views/views.dart';
import 'package:flutter_template/views/widgets/custom_button.dart';
import 'package:flutter_template/views/widgets/custom_text_form_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  static const String id = 'sign_up_View';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  var _password = "";
  var _email = "";
  var _firstName = "";
  var _lastName = "";
  var _projectId = "";
  var _phoneNumber = 0;
  bool load = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 8,
                    ),
                    Container(
                      height: SizeConfig.safeBlockVertical * 25,
                      child: Image.asset(
                        "assets/images/logo.png",
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 2,
                    ),
                    signUpTextWidget(),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 4,
                    ),
                    signUpTextFieldsWidget(),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 8,
                    ),
                    signUpBottomWidget(
                      context,
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 6,
                    ),
                  ],
                ),
                physics: const BouncingScrollPhysics(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column signUpTextWidget() {
    return Column(
      children: [
        Text(
          "SIGN UP",
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
    );
  }

  Column signUpTextFieldsWidget() {
    return Column(
      children: [
        CustomTextFormField(
          textColor: Colors.white,
          hintText: "First Name",
          iconData: Icons.person,
          underLineColor: Palette.buttonColor,
          iconColor: Palette.buttonColor,
          withText: false,
          onSaved: (String? value) {
            setState(() {
              _firstName = value.toString();
            });
          },
          onValidate: (String? value) {
            if (value == null || value.isEmpty) {
              return "First Name shouldn't be empty";
            } else if (value.length < 3) {
              return "First Name must contain at least 3 characters";
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
          hintText: "Last Name",
          iconData: Icons.person,
          underLineColor: Palette.buttonColor,
          iconColor: Palette.buttonColor,
          withText: false,
          onSaved: (String? value) {
            setState(() {
              _lastName = value.toString();
            });
          },
          onValidate: (String? value) {
            if (value == null || value.isEmpty) {
              return "Last Name shouldn't be empty";
            } else if (value.length < 3) {
              return "Last Name must contain at least 3 characters";
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
          hintText: "Email",
          textInputType: TextInputType.emailAddress,
          iconData: Icons.mail,
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
          hintText: "Phone Number",
          textInputType: TextInputType.number,
          iconData: Icons.phone,
          underLineColor: Palette.buttonColor,
          iconColor: Palette.buttonColor,
          withText: false,
          onSaved: (String? value) {
            setState(() {
              _phoneNumber = int.parse(value.toString());
            });
          },
          onValidate: (String? value) {
            if (value == null || value.isEmpty) {
              return "Phone Number shouldn't be empty";
            } else if (value.length != 8) {
              return "Phone Number must contain 8 Numbers";
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
    );
  }

  Column signUpBottomWidget(BuildContext context) {
    return Column(
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
                  "Sign Up",
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
        SizedBox(
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
              "You Already have an account? ",
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
                  LoginView.id,
                );
              },
              child: Text(
                "Login",
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
    );
  }
}
