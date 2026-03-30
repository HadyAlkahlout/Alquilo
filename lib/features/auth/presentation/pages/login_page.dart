import 'package:alquilo/core/resources/assets_manager.dart';
import 'package:alquilo/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/resources/strings_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../core/router/routes.dart';

import '../cubit/login_cubit.dart';
import '../cubit/login_state.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/social_icon_button.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(AppPaddings.p20),
            child: BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state is LoginSuccess) {
                  context.go(Routes.home);
                } else if (state is LoginError) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              builder: (context, state) {
                final cubit = context.read<LoginCubit>();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🔙 Back
                    IconButton(
                      onPressed: () => context.pop(),
                      icon: const Icon(Icons.arrow_back),
                    ),

                    const SizedBox(height: AppPaddings.p20),

                    // 🧠 Title
                    Text(
                      StringsManager.welcomeBack.tr(),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),

                    const SizedBox(height: AppPaddings.p8),

                    Text(StringsManager.loginHint.tr()),

                    const SizedBox(height: AppPaddings.p24),

                    // Toggle login method (email, phone number)
                    Container(
                      height: AppSize.s52,
                      decoration: BoxDecoration(
                        color: ColorManager.toggleBackgroundColor,
                        borderRadius: BorderRadius.circular(AppSize.s12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(AppPaddings.p8),
                        child: Row(
                          spacing: AppPaddings.p8,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: cubit.isLoginWithEmail
                                      ? Theme.of(
                                          context,
                                        ).scaffoldBackgroundColor
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(
                                    AppSize.s12,
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () => cubit.toggleLoginMethod(),
                                  child: Text(
                                    StringsManager.email.tr(),
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: !cubit.isLoginWithEmail
                                      ? Theme.of(
                                          context,
                                        ).scaffoldBackgroundColor
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(
                                    AppSize.s12,
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () => cubit.toggleLoginMethod(),
                                  child: Text(
                                    StringsManager.phoneNumber.tr(),
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: AppPaddings.p28),

                    Text(
                      cubit.isLoginWithEmail
                          ? StringsManager.email.tr()
                          : StringsManager.phoneNumber.tr(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),

                    const SizedBox(height: AppPaddings.p8),

                    // 📧 Email or Phone Number
                    CustomTextField(
                      hint: cubit.isLoginWithEmail
                          ? StringsManager.enterEmail.tr()
                          : StringsManager.enterPhoneNumber.tr(),
                      controller: emailController,
                      isPhone: !cubit.isLoginWithEmail,
                    ),

                    const SizedBox(height: AppPaddings.p16),

                    Text(
                      StringsManager.password.tr(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),

                    const SizedBox(height: AppPaddings.p8),

                    // 🔒 Password
                    CustomTextField(
                      hint: StringsManager.enterPassword.tr(),
                      controller: passwordController,
                      isPassword: true,
                      isHidden: cubit.isPasswordHidden,
                      toggleVisibility: () => cubit.togglePassword(),
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => _forgotPassword(context),
                        child: Text(StringsManager.forgotPassword.tr()),
                      ),
                    ),

                    const SizedBox(height: AppPaddings.p20),

                    // 🔵 Login Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: state is LoginLoading
                            ? null
                            : () => _login(context, cubit),
                        child: state is LoginLoading
                            ? Padding(
                              padding: const EdgeInsets.symmetric(vertical: AppPaddings.p4),
                              child: const CircularProgressIndicator(
                                  color: ColorManager.primaryColor,
                                ),
                            )
                            : Text(StringsManager.signIn.tr()),
                      ),
                    ),

                    const SizedBox(height: AppPaddings.p20),

                    // Divider
                    Row(
                      children: [
                        Expanded(child: Divider()),
                        const SizedBox(width: AppPaddings.p8),
                        Text(StringsManager.orLoginWith.tr()),
                        const SizedBox(width: AppPaddings.p8),
                        Expanded(child: Divider()),
                      ],
                    ),

                    const SizedBox(height: AppPaddings.p16),

                    // Social Login
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SocialIconButton(
                          icon: AssetsManager.icGoogle,
                          onPressed: () => _googleLogin(context),
                        ),
                        const SizedBox(width: AppPaddings.p16),
                        SocialIconButton(
                          icon: AssetsManager.icApple,
                          onPressed: () => _appleLogin(context),
                        ),
                        const SizedBox(width: AppPaddings.p16),
                        SocialIconButton(
                          icon: AssetsManager.icFacebook,
                          onPressed: () => _facebookLogin(context),
                        ),
                      ],
                    ),

                    const Spacer(),

                    // Bottom
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(StringsManager.dontHaveAccount.tr()),
                        TextButton(
                          onPressed: () => _signUp(context),
                          child: Text(StringsManager.signUp.tr()),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _login(BuildContext context, LoginCubit cubit) {
    cubit.login(email: emailController.text, password: passwordController.text);
  }

  void _forgotPassword(BuildContext context) {}

  void _googleLogin(BuildContext context) {}

  void _appleLogin(BuildContext context) {}

  void _facebookLogin(BuildContext context) {}

  void _signUp(BuildContext context) {
    context.push(Routes.register);
  }
}
