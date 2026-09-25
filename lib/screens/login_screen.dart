import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/mock_repository.dart';
import '../theme/app_theme.dart';
import '../widgets/visual.dart';
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
    final top = MediaQuery.sizeOf(context).height * 0.42;

    return Scaffold(
      backgroundColor: AppColors.bgSoft,
      body: Column(
        children: [
          SizedBox(
            height: top,
            child: BlotchBackground(
              child: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    Text(
                      'ContiGO',
                      style: GoogleFonts.fraunces(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ),
                    const Spacer(),
                    const ConnectionIllustration(size: 150),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Transform.translate(
              offset: const Offset(0, -28),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                  boxShadow: AppShadows.card,
                ),
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(28, 32, 28, 28),
                  children: [
                    Text(
                      'Iniciar sesión',
                      style: displayStyle(size: 28, color: AppColors.violetDeep),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Correo institucional universitario',
                      style: GoogleFonts.dmSans(
                        fontSize: 13,
                        color: AppColors.grayDark,
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Correo institucional',
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _password,
                      obscureText: true,
                      decoration: const InputDecoration(hintText: 'Contraseña'),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          '¿Olvidaste tu contraseña?',
                          style: GoogleFonts.dmSans(
                            color: AppColors.violetMid,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _enter,
                            child: const Text('Iniciar sesión'),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.violet, width: 1.5),
                          ),
                          child: const Icon(
                            Icons.handshake_outlined,
                            color: AppColors.violet,
                          ),
                        ),
                      ],
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
                              MaterialPageRoute(
                                builder: (_) => const RegisterScreen(),
                              ),
                            );
                          },
                          child: const Text('Crear cuenta'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
