import 'package:alquilo/core/resources/assets_manager.dart';
import 'package:alquilo/core/resources/strings_manager.dart';
import 'package:alquilo/core/resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../widgets/profile_header.dart';
import '../widgets/profile_menu_item.dart';
import '../widgets/profile_section_title.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppPaddings.p16),
          child: ListView(
            children: [

              /// HEADER
              const ProfileHeader(
                name: "Jenny Wilson",
                email: "wilson@gmail.com",
                image: "https://images.pexels.com/photos/20181989/pexels-photo-20181989.jpeg?_gl=1*bkkjsk*_ga*MTA2MzIxMDQ0Ni4xNzczNjU1NTMy*_ga_8JE65Q40S6*czE3Nzg0MzQ4ODUkbzYkZzEkdDE3Nzg0MzQ4OTEkajU0JGwwJGgw",

              ),

              /// GENERAL
              ProfileSectionTitle(
                title: StringsManager.general.tr(),
              ),

              ProfileMenuItem(
                title: StringsManager.editProfile.tr(),
                icon: AssetsManager.icProfile,
                onTap: () {},
              ),

              ProfileMenuItem(
                title: StringsManager.changePassword.tr(),
                icon: AssetsManager.icChangePass,
                onTap: () {},
              ),

              ProfileMenuItem(
                title: StringsManager.notifications.tr(),
                icon: AssetsManager.icNotification,
                onTap: () {},
              ),

              ProfileMenuItem(
                title: StringsManager.security.tr(),
                icon: AssetsManager.icSecurity,
                onTap: () {},
              ),

              ProfileMenuItem(
                title: StringsManager.language.tr(),
                icon: AssetsManager.icLanguage,
                onTap: () {},
              ),

              /// PREFERENCES
              ProfileSectionTitle(
                title: StringsManager.preferencess.tr(),
              ),

              ProfileMenuItem(
                title: StringsManager.legalPolicies.tr(),
                icon: AssetsManager.icLegal,
                onTap: () {},
              ),

              ProfileMenuItem(
                title: StringsManager.helpSupport.tr(),
                icon: AssetsManager.icHelp,
                onTap: () {},
              ),

              /// Logout
              InkWell(
                borderRadius: BorderRadius.circular(AppSize.s20),
                onTap: (){},
                child: Container(
                  margin: EdgeInsets.only(bottom: AppMargins.m16),
                  padding: EdgeInsets.symmetric(
                    horizontal: AppPaddings.p20,
                    vertical: AppPaddings.p20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s20),
                    border: Border.all(
                      color: Colors.red.withOpacity(.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.logout, color: Colors.red,),

                      SizedBox(width: AppPaddings.p16),

                      Expanded(
                        child: Text(
                          StringsManager.logout.tr(),
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}