import 'package:alquilo/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileMenuItem extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onTap;

  const ProfileMenuItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(AppSize.s20),
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: AppMargins.m16),
        padding: EdgeInsets.symmetric(
          horizontal: AppPaddings.p20,
          vertical: AppPaddings.p20,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s20),
          border: Border.all(
            color: colors.outline.withOpacity(.3),
          ),
        ),
        child: Row(
          children: [
            SvgPicture.asset(icon),

            SizedBox(width: AppPaddings.p16),

            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),

            Icon(
              Icons.arrow_forward_ios_rounded,
              size: AppSize.s16,
              color: Colors.grey.shade500,
            ),
          ],
        ),
      ),
    );
  }
}