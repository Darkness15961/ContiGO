import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/mock_repository.dart';
import '../theme/app_theme.dart';
import 'create_profile_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crear cuenta', style: displayStyle(size: 22))),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(28, 12, 28, 28),
        children: [
          Text(
            'Usa tu correo institucional de la universidad.',
            style: GoogleFonts.dmSans(color: AppColors.grayDark, fontSize: 14),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _name,
            decoration: const InputDecoration(hintText: 'Nombre'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _email,
            decoration: const InputDecoration(hintText: 'Correo institucional'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _password,
            obscureText: true,
            decoration: const InputDecoration(hintText: 'Contraseña'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _confirm,
            obscureText: true,
            decoration: const InputDecoration(hintText: 'Confirmar contraseña'),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              final repo = MockRepository();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => CreateProfileScreen(repo: repo, isFirstTime: true),
                ),
              );
            },
            child: const Text('Crear cuenta'),
          ),
        ],
      ),
    );
  }
}
