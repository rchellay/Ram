import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:spymatch/src/core/config/theme.dart';
import 'package:spymatch/src/features/auth/presentation/providers/auth_provider.dart';

class LoginRegisterScreen extends StatefulWidget {
  const LoginRegisterScreen({super.key});

  @override
  State<LoginRegisterScreen> createState() => _LoginRegisterScreenState();
}

class _LoginRegisterScreenState extends State<LoginRegisterScreen> {
  bool isLogin = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _selectedRole = 'coach';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              _buildHeader(),
              const SizedBox(height: 32),
              _buildAuthToggle(),
              const SizedBox(height: 24),
              _buildForm(),
              const SizedBox(height: 24),
              if (!isLogin) _buildRoleSelection(),
              const SizedBox(height: 24),
              _buildPrimaryButton(context),
              if (isLogin) _buildForgotPassword(),
              _buildSocialLoginDivider(),
              _buildSocialLoginButton(),
              const SizedBox(height: 24),
              _buildTermsAndConditions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.sports_soccer, color: AppTheme.primaryColor, size: 32),
        const SizedBox(width: 8),
        Text(
          'SPYMATCH',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }

  Widget _buildAuthToggle() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFF193328),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(6),
      child: Row(
        children: [
          _buildToggleItem('Iniciar Sesión', true),
          _buildToggleItem('Crear Cuenta', false),
        ],
      ),
    );
  }

  Widget _buildToggleItem(String title, bool value) {
    final bool isSelected = isLogin == value;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isLogin = value;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.black : const Color(0xFF92c9b2),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Email', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            hintText: 'Introduce tu correo electrónico',
            hintStyle: const TextStyle(color: Color(0xFF92c9b2)),
            filled: true,
            fillColor: const Color(0xFF193328),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF326751)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF326751)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppTheme.primaryColor),
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text('Contraseña', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Introduce tu contraseña',
            hintStyle: const TextStyle(color: Color(0xFF92c9b2)),
            filled: true,
            fillColor: const Color(0xFF193328),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF326751)),
            ),
             enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF326751)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppTheme.primaryColor),
            ),
            suffixIcon: const Icon(Icons.visibility, color: Color(0xFF92c9b2)),
          ),
        ),
      ],
    );
  }

  Widget _buildRoleSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Selecciona tu rol', style: TextStyle(color: Color(0xFF92c9b2), fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _RoleButton(icon: Icons.assignment, label: 'Entrenador', isSelected: _selectedRole == 'coach', onTap: () => setState(() => _selectedRole = 'coach'))),
            const SizedBox(width: 16),
            Expanded(child: _RoleButton(icon: Icons.search, label: 'Ojeador', isSelected: _selectedRole == 'scout', onTap: () => setState(() => _selectedRole = 'scout'))),
          ],
        ),
        const SizedBox(height: 16),
        _RoleButton(icon: Icons.compare_arrows, label: 'Ambos roles', isFullWidth: true, isSelected: _selectedRole == 'both', onTap: () => setState(() => _selectedRole = 'both')),
      ],
    );
  }

  Widget _buildPrimaryButton(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return ElevatedButton(
      onPressed: () async {
        try {
          if (isLogin) {
            await authProvider.signIn(
              _emailController.text,
              _passwordController.text,
            );
          } else {
            await authProvider.signUpWithRole(
              _emailController.text,
              _passwordController.text,
              _selectedRole!,
            );
          }
           context.go('/home');
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString())),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: Text(
        isLogin ? 'Iniciar Sesión' : 'Crear Cuenta',
        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  Widget _buildForgotPassword() {
    return TextButton(
      onPressed: () {},
      child: const Text('¿Olvidaste tu contraseña?', style: TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildSocialLoginDivider() {
    return const Row(
      children: [
        Expanded(child: Divider(color: Color(0xFF326751))),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text('o', style: TextStyle(color: Color(0xFF92c9b2))),
        ),
        Expanded(child: Divider(color: Color(0xFF326751))),
      ],
    );
  }

  Widget _buildSocialLoginButton() {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.g_mobiledata, color: Colors.white), // Placeholder for Google Icon
      label: const Text('Continuar con Google', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Color(0xFF326751)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    );
  }

  Widget _buildTermsAndConditions() {
    return Text.rich(
      TextSpan(
        text: 'Al crear una cuenta, aceptas nuestros ',
        style: const TextStyle(color: Color(0xFF92c9b2), fontSize: 12),
        children: [
          TextSpan(text: 'Términos y Condiciones', style: const TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.w500)),
          const TextSpan(text: ' y '),
          TextSpan(text: 'Política de Privacidad', style: const TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.w500)),
          const TextSpan(text: '.'),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}

class _RoleButton extends StatelessWidget {
  const _RoleButton({
    required this.icon,
    required this.label,
    this.isSelected = false,
    this.isFullWidth = false,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final bool isFullWidth;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: isFullWidth ? 80 : 120,
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryColor.withOpacity(0.2) : const Color(0xFF193328),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? AppTheme.primaryColor : const Color(0xFF326751)),
        ),
        child: isFullWidth
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: Colors.white, size: 32),
                  const SizedBox(width: 16),
                  Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: Colors.white, size: 32),
                  const SizedBox(height: 8),
                  Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ],
              ),
      ),
    );
  }
}
