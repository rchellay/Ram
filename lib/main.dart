import 'package:flutter/material.dart';
import 'package:spymatch/src/core/config/theme.dart';
import 'package:spymatch/src/routes/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'SPYMATCH',
      theme: AppTheme.darkTheme,
      routerConfig: AppRouter.router,
    );
  }
}
