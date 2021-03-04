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
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.all(20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          backgroundColor: Color(0xFFF5F6F9),
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              color: mPrimaryColor,
              width: 22,
            ),
            SizedBox(width: 20),
            Expanded(child: Text(text, style: TextStyle(color: mTextColor))),
            Icon(Icons.arrow_forward_ios, color: mTextColor),
          ],
        ),
      ),
    );
  }
}
