import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    userData = AuthService().getUserData();
  }

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
    final name = userData?['full_name'] ?? "Usuário";
    final email = userData?['email'] ?? "email@example.com";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Perfil", style: GoogleFonts.inter(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16)),
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // Avatar e Info do Usuário
              Container(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Column(
                  children: [
                    // Avatar com Gradiente
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFFF59E0B), Color(0xFF10B981)],
                        ),
                      ),
                      child: const CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, size: 50, color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      name,
                      style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      email,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 32, thickness: 1),
              const SizedBox(height: 16),

              // Stats
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    _statRow("Total de Receitas", "2", isBadge: true),
                    const SizedBox(height: 24),
                    _statRow("Membro desde", "Janeiro 2024", isBadge: false),
                  ],
                ),
              ),
              const Divider(height: 32, thickness: 1),
              const SizedBox(height: 16),

              // Menu de Ações
              _actionButton(Icons.edit_outlined, "Editar Perfil", () {}),
              const SizedBox(height: 12),
              _actionButton(Icons.settings_outlined, "Configurações", () {}),
              const SizedBox(height: 12),
              _actionButton(Icons.logout, "Sair", () => _logout(context), isDestructive: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statRow(String label, String value, {bool isBadge = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
        isBadge
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  value,
                  style: GoogleFonts.inter(
                    color: Colors.orange.shade700,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              )
            : Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
      ],
    );
  }

  Widget _actionButton(IconData icon, String text, VoidCallback onTap, {bool isDestructive = false}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isDestructive ? Colors.red.shade200 : Colors.grey.shade200,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isDestructive ? Colors.red.shade500 : Colors.black87,
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              text,
              style: GoogleFonts.inter(
                color: isDestructive ? Colors.red.shade500 : Colors.black87,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
            if (!isDestructive) ...[
              const Spacer(),
              Icon(
                Icons.chevron_right,
                color: Colors.grey.shade400,
                size: 20,
              ),
            ]
          ],
        ),
      ),
    );
  }
}