import 'package:alquilo/core/resources/colors_manager.dart';
import 'package:alquilo/core/resources/values_manager.dart';
import 'package:flutter/material.dart';

class SocialIconButton extends StatelessWidget {
  final String icon;
  final VoidCallback onPressed;

  const SocialIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(AppSize.s12),
      child: Container(
        padding: const EdgeInsets.all(AppPaddings.p12),
        decoration: BoxDecoration(
          border: Border.all(color: ColorManager.lightGrey),
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
        child: Image.asset(icon, width: AppSize.s24),
      ),
    );
  }
}