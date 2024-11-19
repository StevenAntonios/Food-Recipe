import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:meal_app/screens/single_meal_detailed.dart';
import 'package:meal_app/shared/constants/constants.dart';
import 'package:meal_app/shared/styles/textStyles.dart';

class CustomGrid extends StatelessWidget {
  const CustomGrid({
    super.key,
    required this.imgUrl,
    required this.mealName, required this.id,
  });
  final String imgUrl;
  final String mealName;
  final String id;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SingleMealDetailed(
                      id: id ,
                    )));
      },
      child: Container(
        height: 240,
        width: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: Constants.boxShadow,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 170,
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: imgUrl,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    mealName,
                    style: AppTextStyle.titleStyle(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
