import 'package:alquilo/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import '../../../../core/resources/values_manager.dart';
import 'dots_indicator.dart';

class OnboardingItem extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final int dotsNum;
  final int index;

  const OnboardingItem({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.dotsNum,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          image,
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.cover,
        ),

        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorManager.primaryLightColor,
          ),
        ),

        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.all(AppSize.s24),
            decoration: BoxDecoration(
              color: ColorManager.backgroundLight,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppSize.s32),
                topRight: Radius.circular(AppSize.s32),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: AppMargins.m40),

                DotsIndicator(currentIndex: index, count: dotsNum),

                SizedBox(height: AppMargins.m16),

                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.start,
                ),

                SizedBox(height: AppSize.s12),

                Text(description, textAlign: TextAlign.start),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
