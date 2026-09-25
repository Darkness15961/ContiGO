import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/mock_repository.dart';
import '../theme/app_theme.dart';
import 'register_screen.dart';
import 'shell_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController(text: '60859960@continental.edu.pe');
  final _password = TextEditingController(text: '••••••••');

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _enter() {
    final repo = MockRepository();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => ShellScreen(repo: repo)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(28, 48, 28, 28),
          children: [
            Text('ContiGO', style: brandStyle(size: 40)),
            const SizedBox(height: 8),
            Text(
              'Inicia sesión con tu correo institucional',
              style: GoogleFonts.dmSans(fontSize: 15, color: AppColors.grayDark),
            ),
            const SizedBox(height: 36),
            TextField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(hintText: 'Correo institucional'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _password,
              obscureText: true,
              decoration: const InputDecoration(hintText: 'Contraseña'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _enter,
              child: const Text('Iniciar sesión'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '¿No tienes cuenta? ',
                  style: GoogleFonts.dmSans(color: AppColors.grayDark),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const RegisterScreen()),
                    );
                  },
                  child: const Text('Crear cuenta'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
