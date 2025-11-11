import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spymatch/src/features/auth/presentation/screens/login_register_screen.dart';
import 'package:spymatch/src/features/auth/presentation/screens/role_selection_screen.dart';
import 'package:spymatch/src/features/auth/presentation/screens/welcome_screen.dart';
import 'package:spymatch/src/features/create_mission/presentation/screens/create_mission_configure_screen.dart';
import 'package:spymatch/src/features/create_mission/presentation/screens/create_mission_define_match_screen.dart';
import 'package:spymatch/src/features/create_mission/presentation/screens/create_mission_review_screen.dart';
import 'package:spymatch/src/features/create_mission/presentation/screens/create_mission_select_match_screen.dart';
import 'package:spymatch/src/features/home/presentation/screens/main_screen.dart';
import 'package:spymatch/src/features/home/presentation/screens/scout_dashboard_screen.dart';
import 'package:spymatch/src/features/home/presentation/screens/coach_dashboard_screen.dart';
import 'package:spymatch/src/features/missions/presentation/screens/mission_details_screen.dart';
import 'package:spymatch/src/features/missions/presentation/screens/missions_screen.dart';
import 'package:spymatch/src/features/alerts/presentation/screens/alerts_screen.dart';
import 'package:spymatch/src/features/chats/presentation/screens/chats_screen.dart';
import 'package:spymatch/src/features/profile/presentation/screens/profile_screen.dart';
import 'package:spymatch/src/features/reports/presentation/screens/scouting_report_screen.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final router = GoRouter(
    initialLocation: '/',
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginRegisterScreen(),
      ),
      GoRoute(
        path: '/role-selection',
        builder: (context, state) => const RoleSelectionScreen(),
      ),
       GoRoute(
        path: '/coach-dashboard',
        builder: (context, state) => const CoachDashboardScreen(),
      ),
      GoRoute(
        path: '/create-mission/select-match',
        builder: (context, state) => const CreateMissionSelectMatchScreen(),
      ),
       GoRoute(
        path: '/create-mission/define-match',
        builder: (context, state) => const CreateMissionDefineMatchScreen(),
      ),
       GoRoute(
        path: '/create-mission/configure',
        builder: (context, state) => const CreateMissionConfigureScreen(),
      ),
       GoRoute(
        path: '/create-mission/review',
        builder: (context, state) => const CreateMissionReviewScreen(),
      ),
       GoRoute(
        path: '/mission-details',
        builder: (context, state) => const MissionDetailsScreen(),
      ),
       GoRoute(
        path: '/scouting-report',
        builder: (context, state) => const ScoutingReportScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const ScoutDashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/missions',
                builder: (context, state) => const MissionsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/alerts',
                builder: (context, state) => const AlertsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/chats',
                builder: (context, state) => const ChatsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
