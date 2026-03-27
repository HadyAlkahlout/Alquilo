import 'package:alquilo/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import '../../../../core/resources/values_manager.dart';

class DotsIndicator extends StatelessWidget {
  final int currentIndex;
  final int count;

  const DotsIndicator({
    super.key,
    required this.currentIndex,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(count, (index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: AppSize.s4),
          width: currentIndex == index ? AppSize.s40 : AppSize.s8,
          height: AppSize.s8,
          decoration: BoxDecoration(
            color: currentIndex == index
                ? ColorManager.primaryColor
                : ColorManager.lightGrey,
            borderRadius: BorderRadius.circular(AppSize.s40),
          ),
        );
      }),
    );
  }
}
