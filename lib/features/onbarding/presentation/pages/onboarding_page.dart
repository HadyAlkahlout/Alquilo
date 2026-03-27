import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/storage/local_storage.dart';
import '../../../../core/constants/storage_keys.dart';
import '../../../../injection_container.dart';

import '../cubit/onboarding_cubit.dart';
import '../cubit/onboarding_state.dart';
import '../widgets/onboarding_item.dart';

class OnboardingPage extends StatelessWidget {
  OnboardingPage({super.key});

  final PageController _controller = PageController();

  final List<Map<String, String>> pages = [
    {
      "image": AssetsManager.onboarding1,
      "title": StringsManager.onboardingTitle1.tr(),
      "desc": StringsManager.onboardingDescription1.tr(),
    },
    {
      "image": AssetsManager.onboarding2,
      "title": StringsManager.onboardingTitle2.tr(),
      "desc": StringsManager.onboardingDescription2.tr(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingCubit(),
      child: BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, state) {
          final isLast = state.currentIndex == pages.length - 1;

          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _controller,
                    onPageChanged: (index) {
                      context.read<OnboardingCubit>().changePage(index);
                    },
                    itemCount: pages.length,
                    itemBuilder: (context, index) {
                      final item = pages[index];

                      return OnboardingItem(
                        image: item["image"]!,
                        title: item["title"]!.tr(),
                        description: item["desc"]!.tr(),
                        dotsNum: pages.length,
                        index: state.currentIndex,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppSize.s24),
                  child: Row(
                    spacing: AppMargins.m8,
                    children: [
                      Visibility(
                        visible: !isLast,
                        child: Expanded(
                          child: OutlinedButton(
                            onPressed: () => _onSkip(context),
                            style: OutlinedButton.styleFrom(
                              fixedSize: Size(double.infinity, AppSize.s52),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(AppSize.s24),
                              ),
                            ),
                            child: Text(
                              StringsManager.skip.tr(),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _onNext(isLast, context),
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(double.infinity, AppSize.s52),
                          ),
                          child: Text(
                            isLast ? StringsManager.getStarted.tr() : StringsManager.next.tr(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onNext(bool isLast, BuildContext context) {
    if (isLast) {
      _onSkip(context);
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void _onSkip(BuildContext context) {
    final storage = sl<LocalStorage>();
    storage.setBool(StorageKeys.onboardingSeen, true);
    context.go(Routes.getStarted);
  }
}
