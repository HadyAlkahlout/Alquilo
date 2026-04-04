import 'package:alquilo/core/resources/assets_manager.dart';
import 'package:alquilo/core/resources/strings_manager.dart';
import 'package:alquilo/core/resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ChangedPasswordSuccess extends StatelessWidget {
  const ChangedPasswordSuccess({super.key, required this.goLogin});

  final void Function() goLogin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPaddings.p16),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(AppSize.s32),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppPaddings.p20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  AssetsManager.icSuccess,
                  width: AppSize.s120,
                ),

                const SizedBox(height: AppPaddings.p16),

                // 🧠 Title
                Text(
                  StringsManager.passwordChangedTitle.tr(),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),

                const SizedBox(height: AppPaddings.p8),

                Text(StringsManager.passwordChangedDescription.tr()),

                const SizedBox(height: AppPaddings.p36),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => goLogin(),
                    child: Text(StringsManager.loginNow.tr()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
