import 'package:alquilo/core/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/resources/values_manager.dart';

import '../widgets/social_button.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppPaddings.p20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),

              // 🧠 Title
              Text(
                StringsManager.getStartedTitle.tr(),
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),

              SizedBox(height: AppSize.s12),

              // 📝 Description
              Text(
                StringsManager.getStartedDescription.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(color: colors.onBackground.withOpacity(0.6)),
              ),

              SizedBox(height: AppSize.s32),

              // 🔵 Main Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _emailSignup(context),
                  child: Text(StringsManager.emailSignup.tr()),
                ),
              ),

              SizedBox(height: AppSize.s16),

              // 🔸 Divider Text
              Text(StringsManager.orHint.tr()),

              SizedBox(height: AppSize.s16),

              // 🔴 Google
              SocialButton(
                text: StringsManager.googleSignup.tr(),
                icon: AssetsManager.icGoogle,
                onPressed: () => _googleSignup(),
              ),

              SizedBox(height: AppSize.s12),

              // ⚫ Apple
              SocialButton(
                text: StringsManager.appleSignup.tr(),
                icon: AssetsManager.icApple,
                onPressed: () => _appleSignup(),
              ),

              const Spacer(),

              // 🔻 Bottom Text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(StringsManager.haveAccount.tr()),
                  TextButton(
                    onPressed: () => _signIn(context),
                    child: Text(StringsManager.signIn.tr()),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _emailSignup(BuildContext context) {
    context.push(Routes.register);
  }

  void _googleSignup() {}

  void _appleSignup() {}

  void _signIn(BuildContext context) {
    context.push(Routes.login);
  }
}
