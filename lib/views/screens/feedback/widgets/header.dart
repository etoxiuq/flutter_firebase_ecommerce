import 'package:e_commerce_app/views/screens/feedback/widgets/star_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:e_commerce_app/constants/color_constant.dart';

class Header extends StatefulWidget {
  const Header({
    Key key,
  }) : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  // init states
  int selectedStarIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFF5F6F9), width: 1),
        ),
      ),
      child: Column(
        children: [
          /// Average rating
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(15),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${5}",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                RatingBar.builder(
                  initialRating: 5,
                  minRating: 1,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 26,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: null,
                ),
                const SizedBox(height: 15),
                Text(
                  "${100} nhận xét",
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),

          /// Detail
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Get all feedbacks button
                GestureDetector(
                  onTap: () {
                    setState(() => selectedStarIndex = 0);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "All",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color:
                            selectedStarIndex == 0 ? mPrimaryColor : mTextColor,
                      ),
                    ),
                  ),
                ),

                // Get feedbacks by number of stars
                ...List.generate(5, (index) {
                  return StarButton(
                    numberOfStars: 5 - index,
                    isActive: selectedStarIndex == 5 - index,
                    handleOnTap: () {
                      setState(() => selectedStarIndex = 5 - index);
                      // get feedbacks by star ( 1 -> 5)
                    },
                  );
                })
              ],
            ),
          )
        ],
      ),
    );
  }
}
