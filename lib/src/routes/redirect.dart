import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:spymatch/src/features/auth/presentation/providers/auth_provider.dart';

class Redirect {
  final BuildContext context;
  Redirect(this.context);

  Future<String?> call(BuildContext context, GoRouterState state) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final isAuth = authProvider.user != null;

    final isLoginRoute = state.matchedLocation == '/login';

    if (!isAuth && !isLoginRoute) {
      return '/';
    }

    if (isAuth && isLoginRoute) {
      return '/role-selection';
    }

    return null;
  }
}
