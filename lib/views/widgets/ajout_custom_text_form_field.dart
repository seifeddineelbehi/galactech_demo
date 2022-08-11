import 'package:flutter/material.dart';
import 'package:flutter_template/utils/constants.dart';
import 'package:flutter_template/utils/palette.dart';
import 'package:flutter_template/utils/size_config.dart';
import 'package:flutter_template/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class AjoutCustomTextFormField extends StatefulWidget {
  final String text;
  final String hintText;
  final IconData iconData;
  final Color? iconColor;
  final Color underLineColor;
  final Color textColor;
  final Color titleColor;
  final Function(String?)? onSaved;
  final String? Function(String?)? onValidate;
  final bool obscureText;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final bool withText;
  final bool withTextPreview;
  final double padding;
  final int maxLines;
  final TextEditingController? controller;
  AjoutCustomTextFormField({
    Key? key,
    this.text = "",
    required this.hintText,
    required this.iconData,
    required this.iconColor,
    required this.onSaved,
    required this.underLineColor,
    required this.textColor,
    required this.onValidate,
    this.textInputAction = TextInputAction.done,
    this.textInputType = TextInputType.text,
    this.obscureText = false,
    this.withText = true,
    this.withTextPreview = false,
    this.titleColor = Colors.white,
    this.padding = 8,
    this.maxLines = 1,
    this.controller,
  }) : super(key: key);

  @override
  State<AjoutCustomTextFormField> createState() => _AjoutCustomTextFormFieldState();
}

class _AjoutCustomTextFormFieldState extends State<AjoutCustomTextFormField> {
  late TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      // if we made the controller ourselves, we dispose it ourselves
      // but if it's made outside of this widget, it should be disposed outside
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.safeBlockHorizontal * 65,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: widget.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.withText
                ? Text(
                    widget.hintText + ":",
                    style: GoogleFonts.poppins(
                      color: widget.titleColor,
                      fontWeight: FontWeight.w600,
                      fontSize: SizeConfig.kDefaultSize * 4.8,
                    ),
                  )
                : const SizedBox.shrink(),
            SizedBox(
              height: SizeConfig.safeBlockVertical * 2,
            ),
            Container(
              decoration: BoxDecoration(
                color: Palette.textFieldColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Palette.textFieldColor.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                child: TextFormField(
                  controller: widget.controller,
                  style: TextStyle(
                    color: widget.textColor,
                    fontSize: SizeConfig.kDefaultSize * 4.5,
                    fontWeight: FontWeight.w500,
                  ),
                  textInputAction: widget.textInputAction,
                  obscureText: widget.obscureText,
                  maxLines: widget.maxLines,
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: TextStyle(
                      fontSize: SizeConfig.kDefaultSize * 4.5,
                      fontWeight: FontWeight.w500,
                      color: Palette.textSecondaryColor,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  keyboardType: widget.textInputType,
                  onSaved: widget.onSaved,
                  validator: widget.onValidate,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
