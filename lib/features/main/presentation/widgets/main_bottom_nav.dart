import 'package:alquilo/core/resources/assets_manager.dart';
import 'package:alquilo/core/resources/colors_manager.dart';
import 'package:alquilo/core/resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const MainBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AssetsManager.icHome),
          activeIcon: SvgPicture.asset(AssetsManager.icHomeActive),
          label: StringsManager.home.tr(),
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AssetsManager.icSearch),
          activeIcon: SvgPicture.asset(AssetsManager.icSearchActive),
          label: StringsManager.search.tr(),
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AssetsManager.icMessage),
          activeIcon: SvgPicture.asset(AssetsManager.icMessageActive),
          label: StringsManager.messages.tr(),
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AssetsManager.icProfile),
          activeIcon: SvgPicture.asset(AssetsManager.icProfileActive),
          label: StringsManager.profile.tr(),
        ),
      ],
    );
  }
}
