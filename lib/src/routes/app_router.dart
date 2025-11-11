import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:spymatch/src/features/auth/presentation/providers/auth_provider.dart';
import 'package:spymatch/src/features/auth/presentation/screens/login_register_screen.dart';
import 'package:spymatch/src/features/auth/presentation/screens/role_selection_screen.dart';
import 'package:spymatch/src/features/auth/presentation/screens/welcome_screen.dart';
import 'package:spymatch/src/features/chats/presentation/screens/chat_detail_screen.dart';
import 'package:spymatch/src/features/home/presentation/screens/main_screen.dart';
import 'package:spymatch/src/features/home/presentation/screens/scout_dashboard_screen.dart';
import 'package:spymatch/src/features/home/presentation/screens/coach_dashboard_screen.dart';
import 'package:spymatch/src/features/missions/presentation/screens/mission_details_screen.dart';
import 'package:spymatch/src/features/missions/presentation/screens/missions_screen.dart';
import 'package:spymatch/src/features/alerts/presentation/screens/alerts_screen.dart';
import 'package:spymatch/src/features/chats/presentation/screens/chats_screen.dart';
import 'package:spymatch/src/features/payments/presentation/screens/payment_settings_screen.dart';
import 'package:spymatch/src/features/payments/presentation/screens/subscriptions_screen.dart';
import 'package:spymatch/src/features/profile/presentation/screens/profile_screen.dart';
import 'package:spymatch/src/features/reports/presentation/screens/create_report_screen.dart';
import 'package:spymatch/src/features/reports/presentation/screens/scouting_report_screen.dart';
import 'package:spymatch/src/routes/redirect.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter router(BuildContext context) {
    final redirect = Redirect(context).call;

    return GoRouter(
      initialLocation: '/',
      navigatorKey: _rootNavigatorKey,
      redirect: redirect,
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
        GoRoute(
          path: '/create-report',
          builder: (context, state) => const CreateReportScreen(),
        ),
        GoRoute(
          path: '/chat/:chatId',
          builder: (context, state) =>
              ChatDetailScreen(chatId: state.pathParameters['chatId']!),
        ),
        GoRoute(
          path: '/payment-settings',
          builder: (context, state) => const PaymentSettingsScreen(),
        ),
        GoRoute(
          path: '/subscriptions',
          builder: (context, state) => const SubscriptionsScreen(),
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
}
