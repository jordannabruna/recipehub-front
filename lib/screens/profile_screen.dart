import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _logout(BuildContext context) async {
    await AuthService().logout();
    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
        context, 
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(title: const Text("Perfil"), centerTitle: true, elevation: 1, backgroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Card Usuário
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.green.shade100,
                    child: const Icon(Icons.person, size: 40, color: Colors.green),
                  ),
                  const SizedBox(height: 16),
                  Text("Usuário Logado", style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold)),
                  const Text("usuario@email.com", style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Card Stats
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total de Receitas"),
                  CircleAvatar(radius: 14, backgroundColor: Colors.orange, child: Text("2", style: TextStyle(color: Colors.white, fontSize: 12))),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Botões de Ação
            _buildActionTile(Icons.edit, "Editar Perfil", () {}),
            const SizedBox(height: 8),
            _buildActionTile(Icons.settings, "Configurações", () {}),
            const SizedBox(height: 8),
            _buildActionTile(Icons.logout, "Sair", () => _logout(context), isDestructive: true),
          ],
        ),
      ),
    );
  }

  Widget _buildActionTile(IconData icon, String text, VoidCallback onTap, {bool isDestructive = false}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: isDestructive ? Colors.red.shade100 : Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Icon(icon, color: isDestructive ? Colors.red : Colors.black87, size: 20),
            const SizedBox(width: 12),
            Text(text, style: TextStyle(color: isDestructive ? Colors.red : Colors.black87, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}