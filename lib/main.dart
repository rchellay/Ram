import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spymatch/firebase_options.dart';
import 'package:spymatch/src/core/config/theme.dart';
import 'package:spymatch/src/features/auth/data/repositories/firebase_auth_repository.dart';
import 'package:spymatch/src/features/auth/presentation/providers/auth_provider.dart';
import 'package:spymatch/src/features/chats/data/repositories/firestore_chat_repository.dart';
import 'package:spymatch/src/features/chats/presentation/providers/chat_provider.dart';
import 'package:spymatch/src/features/missions/data/repositories/firestore_mission_repository.dart';
import 'package:spymatch/src/features/missions/presentation/providers/mission_provider.dart';
import 'package:spymatch/src/routes/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(authRepository: FirebaseAuthRepository()),
        ),
        ChangeNotifierProvider(
          create: (_) => MissionProvider(missionRepository: FirestoreMissionRepository()),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatProvider(chatRepository: FirestoreChatRepository()),
        ),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp.router(
            title: 'SPYMATCH',
            theme: AppTheme.darkTheme,
            routerConfig: AppRouter.router(context),
          );
        }
      ),
    );
  }
}
