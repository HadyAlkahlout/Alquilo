import 'package:alquilo/core/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../cubit/main_cubit.dart';
import '../cubit/main_state.dart';
import '../widgets/main_bottom_nav.dart';

class MainPage extends StatelessWidget {
  final Widget child;

  const MainPage({super.key, required this.child});

  int _getIndexFromRoute(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    if (location.startsWith(Routes.home)) return 0;
    if (location.startsWith(Routes.search)) return 1;
    if (location.startsWith(Routes.messages)) return 2;
    if (location.startsWith(Routes.profile)) return 3;

    return 0;
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        if (_getIndexFromRoute(context) != 0) {
          context.go(Routes.home);
        }
        break;
      case 1:
        if (_getIndexFromRoute(context) != 1) {
          context.go(Routes.search);
        }
        break;
      case 2:
        if (_getIndexFromRoute(context) != 2) {
          context.go(Routes.messages);
        }
        break;
      case 3:
        if (_getIndexFromRoute(context) != 3) {
          context.go(Routes.profile);
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    print(child.toString());
    return BlocProvider(
      create: (_) => MainCubit(),
      child: Builder(
        builder: (context) {
          final cubit = context.read<MainCubit>();

          final currentIndex = _getIndexFromRoute(context);

          cubit.currentIndex = currentIndex;

          return Scaffold(
            body: child,

            bottomNavigationBar: BlocBuilder<MainCubit, MainState>(
              builder: (context, state) {
                return MainBottomNav(
                  currentIndex: cubit.currentIndex,
                  onTap: (index) {
                    cubit.changeTab(index);
                    _onTap(context, index);
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
