import 'package:e_commerce_app/configs/size_config.dart';
import 'package:e_commerce_app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:e_commerce_app/constants/color_constant.dart';

class ProfileMenuButton extends StatelessWidget {
  const ProfileMenuButton({
    Key? key,
    required this.text,
    required this.icon,
    this.onPressed,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.defaultSize * 2,
        vertical: SizeConfig.defaultSize,
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(SizeConfig.defaultSize * 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          backgroundColor: Color(0xFFF5F6F9),
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              color: mPrimaryColor,
              width: SizeConfig.defaultSize * 2,
            ),
            SizedBox(width: SizeConfig.defaultSize * 2),
            Expanded(child: Text(text, style: FONT_CONST.MEDIUM_DEFAULT_16)),
            Icon(Icons.arrow_forward_ios, color: mTextColor),
          ],
        ),
      ),
    );
  }
}