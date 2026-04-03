import 'package:alquilo/core/resources/colors_manager.dart';
import 'package:alquilo/core/router/routes.dart';
import 'package:alquilo/core/utils/validators.dart';
import 'package:alquilo/features/auth/presentation/model/request_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../core/resources/strings_manager.dart';
import '../../../../core/resources/values_manager.dart';

import '../cubit/register/register_cubit.dart';
import '../cubit/register/register_state.dart';
import '../widgets/custom_text_field.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterCubit(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(AppPaddings.p20),
            child: BlocConsumer<RegisterCubit, RegisterState>(
              listener: (context, state) {
                if (state is RegisterSuccess) {
                  RequestOtp requestOtp = RequestOtp(phoneController.text, true);
                  context.go(Routes.otp, extra: requestOtp);
                } else if (state is RegisterError) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              builder: (context, state) {
                final cubit = context.read<RegisterCubit>();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🔙 Back
                    IconButton(
                      onPressed: () => context.pop(),
                      icon: const Icon(Icons.arrow_back),
                    ),

                    const SizedBox(height: 20),

                    // 🧠 Title
                    Text(
                      StringsManager.signUpTitle.tr(),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),

                    const SizedBox(height: 8),

                    Text(StringsManager.signUpDescription.tr()),

                    const SizedBox(height: AppPaddings.p24),

                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            StringsManager.fullName.tr(),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),

                          const SizedBox(height: AppPaddings.p8),

                          // 👤 Name
                          CustomTextField(
                            hint: StringsManager.enterFullName.tr(),
                            controller: nameController,
                            validator: Validators.name,
                          ),

                          const SizedBox(height: AppPaddings.p16),

                          Text(
                            StringsManager.email.tr(),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),

                          const SizedBox(height: AppPaddings.p8),

                          // 📧 Email
                          CustomTextField(
                            hint: StringsManager.enterEmail.tr(),
                            controller: emailController,
                            validator: Validators.email,
                          ),

                          const SizedBox(height: AppPaddings.p16),

                          Text(
                            StringsManager.phoneNumber.tr(),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),

                          const SizedBox(height: AppPaddings.p8),

                          // Phone number
                          CustomTextField(
                            hint: StringsManager.enterPhoneNumber.tr(),
                            controller: phoneController,
                            validator: Validators.phoneNumber,
                            isPhone: true,
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
                            validator: Validators.password,
                          ),

                          const SizedBox(height: AppPaddings.p16),

                          // ☑️ Terms
                          Row(
                            children: [
                              Checkbox(
                                value: cubit.isChecked,
                                onChanged: (value) =>
                                    cubit.toggleTerms(value ?? false),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          StringsManager.termsDescription.tr(),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      spacing: AppPaddings.p4,
                                      children: [
                                        InkWell(
                                          onTap: () => _openTerms(context),
                                          child: Text(
                                            StringsManager.termsAndConditions
                                                .tr(),
                                            style: const TextStyle(
                                              color: ColorManager.primaryColor,
                                            ),
                                          ),
                                        ),
                                        Text(StringsManager.and.tr()),
                                        InkWell(
                                          onTap: () => _openPrivacy(context),
                                          child: Text(
                                            StringsManager.privacyNotice.tr(),
                                            style: const TextStyle(
                                              color: ColorManager.primaryColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: AppPaddings.p24),

                          // 🔵 Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed:
                                  state is RegisterLoading || !cubit.isChecked
                                  ? null
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        _signUp(context, cubit);
                                      }
                                    },
                              child: state is RegisterLoading
                                  ? const CircularProgressIndicator()
                                  : Text(StringsManager.signUp.tr()),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),

                    // 🔻 Bottom
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(StringsManager.haveAccount.tr()),
                        TextButton(
                          onPressed: () {
                            context.pop();
                          },
                          child: Text(StringsManager.signIn.tr()),
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

  void _openTerms(BuildContext context) {}

  void _openPrivacy(BuildContext context) {}

  void _signUp(BuildContext context, RegisterCubit cubit) {
    cubit.register(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
    );
  }
}
