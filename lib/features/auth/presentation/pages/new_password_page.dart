import 'package:alquilo/core/resources/colors_manager.dart';
import 'package:alquilo/core/resources/strings_manager.dart';
import 'package:alquilo/core/resources/values_manager.dart';
import 'package:alquilo/core/router/routes.dart';
import 'package:alquilo/features/auth/presentation/cubit/reset_password/reset_password_cubit.dart';
import 'package:alquilo/features/auth/presentation/cubit/reset_password/reset_password_state.dart';
import 'package:alquilo/features/auth/presentation/widgets/changed_password_success.dart';
import 'package:alquilo/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NewPasswordPage extends StatelessWidget {
  NewPasswordPage({super.key});

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ResetPasswordCubit(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(AppPaddings.p20),
            child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
              listener: (context, state) {
                if (state is ResetPasswordSuccess) {
                  _success(context);
                } else if (state is ResetPasswordError) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              builder: (context, state) {
                final cubit = context.read<ResetPasswordCubit>();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🔙 Back
                    IconButton(
                      onPressed: () => context.pop(),
                      icon: const Icon(Icons.arrow_back),
                    ),

                    const SizedBox(height: AppPaddings.p24),

                    // 🧠 Title
                    Text(
                      StringsManager.newPasswordTitle.tr(),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),

                    const SizedBox(height: AppPaddings.p8),

                    Text(StringsManager.newPasswordDescription.tr()),

                    const SizedBox(height: AppPaddings.p40),

                    Text(
                      StringsManager.newPasswordTitle.tr(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),

                    const SizedBox(height: AppPaddings.p8),

                    // 🔒 Password
                    CustomTextField(
                      hint: StringsManager.newPasswordTitle.tr(),
                      controller: passwordController,
                      isPassword: true,
                      isHidden: cubit.isPasswordHidden,
                      toggleVisibility: () => cubit.togglePassword(),
                    ),

                    const SizedBox(height: AppPaddings.p24),

                    Text(
                      StringsManager.confirmNewPassword.tr(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),

                    const SizedBox(height: AppPaddings.p8),

                    // 🔒 Password
                    CustomTextField(
                      hint: StringsManager.confirmNewPassword.tr(),
                      controller: confirmPasswordController,
                      isPassword: true,
                      isHidden: cubit.isPasswordHidden,
                      toggleVisibility: () => cubit.togglePassword(),
                    ),

                    const SizedBox(height: AppPaddings.p36),

                    // 🔵 Continue Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: state is ResetPasswordLoading
                            ? null
                            : () => _continue(context, cubit),
                        child: state is ResetPasswordLoading
                            ? Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: AppPaddings.p4,
                          ),
                          child: const CircularProgressIndicator(
                            color: ColorManager.primaryColor,
                          ),
                        )
                            : Text(StringsManager.createNewPassword.tr()),
                      ),
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

  void _continue(BuildContext context, ResetPasswordCubit cubit) {
    cubit.reset(
      pass: passwordController.text,
      confirm: confirmPasswordController.text,
    );
  }

  void _success(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return ChangedPasswordSuccess(goLogin: () => _login(context));
      },
    );
  }


  void _login(BuildContext context) {
    context.go(Routes.login, extra: false);
  }
}
