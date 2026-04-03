import 'package:alquilo/core/resources/assets_manager.dart';
import 'package:alquilo/core/resources/colors_manager.dart';
import 'package:alquilo/core/resources/strings_manager.dart';
import 'package:alquilo/core/resources/values_manager.dart';
import 'package:alquilo/core/router/routes.dart';
import 'package:alquilo/features/auth/presentation/model/request_otp.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../cubit/forgot_password/forgot_password_cubit.dart';
import '../cubit/forgot_password/forgot_password_state.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ForgotPasswordCubit(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(AppPaddings.p20),
            child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
              listener: (context, state) {
                if (state is ForgotPasswordSuccess) {
                  RequestOtp requestOtp = RequestOtp(state.value, true);
                  context.go(Routes.otp, extra: requestOtp);
                } else if (state is ForgotPasswordError) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              builder: (context, state) {
                final cubit = context.read<ForgotPasswordCubit>();

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
                      StringsManager.forgotPasswordTitle.tr(),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),

                    const SizedBox(height: AppPaddings.p8),

                    Text(StringsManager.forgotPasswordDescription.tr()),

                    const SizedBox(height: AppPaddings.p24),

                    RadioGroup(
                      groupValue: cubit.method,
                      onChanged: (value) {
                        cubit.changeMethod(value ?? 0);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: AppPaddings.p8,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(AppPaddings.p8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppSize.s12),
                              border: Border.all(color: ColorManager.lightGrey),
                            ),
                            child: Row(
                              spacing: AppPaddings.p8,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(AppPaddings.p8),
                                  child: Container(
                                    padding: const EdgeInsets.all(
                                      AppPaddings.p8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: ColorManager.lightGrey,
                                      borderRadius: BorderRadius.circular(
                                        AppSize.s52,
                                      ),
                                    ),
                                    child: Image.asset(
                                      AssetsManager.icMail,
                                      width: AppSize.s20,
                                      height: AppSize.s20,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    spacing: AppPaddings.p8,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        StringsManager.email.tr(),
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyLarge,
                                      ),
                                      Text(
                                        "*****@gmail.com",
                                        style: Theme.of(
                                          context,
                                        ).textTheme.labelSmall,
                                      ),
                                    ],
                                  ),
                                ),
                                Radio(value: 0),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(AppPaddings.p8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppSize.s12),
                              border: Border.all(color: ColorManager.lightGrey),
                            ),
                            child: Row(
                              spacing: AppPaddings.p8,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(AppPaddings.p8),
                                  child: Container(
                                    padding: const EdgeInsets.all(
                                      AppPaddings.p8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: ColorManager.lightGrey,
                                      borderRadius: BorderRadius.circular(
                                        AppSize.s52,
                                      ),
                                    ),
                                    child: Image.asset(
                                      AssetsManager.icPhone,
                                      width: AppSize.s20,
                                      height: AppSize.s20,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    spacing: AppPaddings.p8,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        StringsManager.phoneNumber.tr(),
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyLarge,
                                      ),
                                      Text(
                                        "********6788",
                                        style: Theme.of(
                                          context,
                                        ).textTheme.labelSmall,
                                      ),
                                    ],
                                  ),
                                ),
                                Radio(value: 1),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppPaddings.p20),

                    // 🔵 Continue Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: state is ForgotPasswordLoading
                            ? null
                            : () => _continue(context, cubit),
                        child: state is ForgotPasswordLoading
                            ? Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: AppPaddings.p4,
                          ),
                          child: const CircularProgressIndicator(
                            color: ColorManager.primaryColor,
                          ),
                        )
                            : Text(StringsManager.continueButton.tr()),
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

  void _continue(BuildContext context, ForgotPasswordCubit cubit) {
    cubit.sendCode("123456");
  }

}
