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
  String? _error;

  static final _institutional = RegExp(
    r'^[^@\s]+@continental\.edu\.pe$',
    caseSensitive: false,
  );

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  void _submit() {
    final name = _name.text.trim();
    final email = _email.text.trim().toLowerCase();
    final pass = _password.text;
    final confirm = _confirm.text;

    if (name.isEmpty || email.isEmpty || pass.isEmpty) {
      setState(() => _error = 'Completa nombre, correo y contraseña.');
      return;
    }
    if (!_institutional.hasMatch(email)) {
      setState(
        () => _error = 'Usa tu correo institucional (@continental.edu.pe).',
      );
      return;
    }
    if (pass.length < 6) {
      setState(() => _error = 'La contraseña debe tener al menos 6 caracteres.');
      return;
    }
    if (pass != confirm) {
      setState(() => _error = 'Las contraseñas no coinciden.');
      return;
    }

    final repo = MockRepository.newAccount(name: name, email: email);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => CreateProfileScreen(repo: repo, isFirstTime: true),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crear cuenta', style: displayStyle(size: 22))),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(28, 12, 28, 28),
        children: [
          Text(
            'Regístrate con tu correo @continental.edu.pe. Luego completarás sede, modalidad y qué te mueve.',
            style: GoogleFonts.dmSans(color: AppColors.grayDark, fontSize: 14),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _name,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(labelText: 'Nombre completo'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Correo institucional',
              hintText: 'codigo@continental.edu.pe',
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _password,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Contraseña'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _confirm,
            obscureText: true,
            decoration:
                const InputDecoration(labelText: 'Confirmar contraseña'),
          ),
          if (_error != null) ...[
            const SizedBox(height: 12),
            Text(
              _error!,
              style: GoogleFonts.dmSans(
                color: AppColors.orange,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ],
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _submit,
            child: const Text('Crear cuenta'),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Ya tengo cuenta'),
          ),
        ],
      ),
    );
  }
}
