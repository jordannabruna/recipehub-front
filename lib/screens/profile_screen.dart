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
      appBar: AppBar(
        title: Text("Perfil", style: GoogleFonts.inter(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16)),
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Card Usuário
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(colors: [Color(0xFFF59E0B), Color(0xFF10B981)]),
                    ),
                    child: const CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, size: 40, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text("João Silva", style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold, color: const Color(0xFF111827))),
                  Text("joao.silva@email.com", style: GoogleFonts.inter(color: Colors.grey[500])),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Card Stats (Total Receitas / Membro Desde)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white, 
                borderRadius: BorderRadius.circular(12), 
                border: Border.all(color: Colors.grey.shade200)
              ),
              child: Column(
                children: [
                  _statRow("Total de Receitas", "2", isBadge: true),
                  const Divider(height: 32),
                  _statRow("Membro desde", "Janeiro 2024", isBadge: false),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Menu de Ações
            _actionButton(Icons.edit_outlined, "Editar Perfil", () {}),
            const SizedBox(height: 12),
            _actionButton(Icons.settings_outlined, "Configurações", () {}),
            const SizedBox(height: 12),
            _actionButton(Icons.logout, "Sair", () => _logout(context), isDestructive: true),
          ],
        ),
      ),
    );
  }

  Widget _statRow(String label, String value, {bool isBadge = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.inter(color: Colors.grey[700], fontWeight: FontWeight.w500)),
        isBadge 
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(color: Colors.orange.shade100, borderRadius: BorderRadius.circular(12)),
              child: Text(value, style: TextStyle(color: Colors.orange.shade800, fontWeight: FontWeight.bold, fontSize: 12)),
            )
          : Text(value, style: GoogleFonts.inter(color: Colors.grey[500])),
      ],
    );
  }

  Widget _actionButton(IconData icon, String text, VoidCallback onTap, {bool isDestructive = false}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: isDestructive ? Colors.red.shade50.withOpacity(0.5) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: isDestructive ? Colors.red.shade100 : Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Icon(icon, color: isDestructive ? Colors.red : Colors.black87, size: 20),
            const SizedBox(width: 12),
            Text(text, style: GoogleFonts.inter(
              color: isDestructive ? Colors.red : Colors.black87, 
              fontWeight: FontWeight.w500)
            ),
            if (!isDestructive) ...[
              const Spacer(),
              Icon(Icons.chevron_right, color: Colors.grey.shade400, size: 20),
            ]
          ],
        ),
      ),
    );
  }
}