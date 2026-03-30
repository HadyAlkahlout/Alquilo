import 'package:alquilo/core/resources/colors_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code/pin_code.dart';

import '../../../../core/resources/values_manager.dart';
import '../../../../core/resources/strings_manager.dart';

import '../cubit/otp_cubit.dart';
import '../cubit/otp_state.dart';

class OtpPage extends StatelessWidget {
  OtpPage({super.key, required this.phoneNumber});

  String code = '';

  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OtpCubit()..startTimer(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(AppPaddings.p20),
            child: BlocConsumer<OtpCubit, OtpState>(
              listener: (context, state) {
                if (state is OtpSuccess) {
                  context.go('/home');
                } else if (state is OtpError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                final cubit = context.read<OtpCubit>();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🔙 Back
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: IconButton(
                        onPressed: () => context.pop(),
                        icon: const Icon(Icons.arrow_back),
                      ),
                    ),

                    const SizedBox(height: AppPaddings.p20),

                    Text(
                      StringsManager.verifyPhone.tr(),
                      style:
                      Theme.of(context).textTheme.headlineMedium,
                    ),

                    const SizedBox(height: AppPaddings.p8),

                    Text(
                      StringsManager.verifyPhoneDescription.tr(),
                      textAlign: TextAlign.center,
                    ),

                    Text(
                      "($phoneNumber)",
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: AppPaddings.p24),

                    // 🔢 Code Field
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: PinCode(
                          appContext: context,
                          length: 4,
                          keyboardType: TextInputType.number,
                          pinTheme: PinCodeTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(AppSize.s12),
                            fieldHeight: AppSize.s48,
                            fieldWidth: AppSize.s72,
                            activeColor: ColorManager.primaryColor,
                            activeFillColor: ColorManager.activeFiledColor,
                            inactiveColor: ColorManager.lightGrey,
                            selectedColor: ColorManager.primaryColor,
                          ),
                          textStyle: TextStyle(
                            fontSize: AppSize.s24,
                          ),
                          onChanged: (value) {
                            print(value);
                          },
                          onCompleted: (value) {
                            print("Completed: $value");
                            // Show a dialog or navigate to the next screen
                            code = value;
                            _verifyCode(cubit, value);
                          },
                        ),
                      ),
                    ),

                    // ⏱ Timer
                    if (cubit.seconds > 0)
                      Text("${StringsManager.resendCodeIn.tr()} ${cubit.seconds}${StringsManager.second.tr()}")
                    else
                      TextButton(
                        onPressed: () => _resendCode(cubit),
                        child: Text(StringsManager.resendCode.tr(),),
                      ),

                    const SizedBox(height: AppPaddings.p24),

                    // 🔵 Verify Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: state is OtpLoading
                            ? null
                            : () {
                          _verifyCode(cubit, code);
                        },
                        child: state is OtpLoading
                            ? Padding(
                              padding: const EdgeInsets.symmetric(vertical: AppPaddings.p4),
                              child: const CircularProgressIndicator(),
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

  void _verifyCode(OtpCubit cubit, String code){
    cubit.verifyCode(phone: phoneNumber, code: code);
  }

  void _resendCode(OtpCubit cubit){
    cubit.resendCode(phoneNumber);
  }
}