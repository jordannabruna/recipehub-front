import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';
import 'main_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final confirmPassCtrl = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.orange.shade400,
                        Colors.green.shade400,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(
                    Icons.person_add,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),

                // Título
                Text(
                  "Criar Conta",
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 8),

                // Subtítulo
                Text(
                  "Junte-se ao RecipeHub",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                // Formulário
                SizedBox(
                  width: 380,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Nome
                        TextFormField(
                          controller: nameCtrl,
                          decoration: InputDecoration(
                            hintText: "Nome completo",
                            hintStyle: GoogleFonts.inter(color: Colors.grey.shade500),
                            prefixIcon: const Icon(Icons.person_outline, color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                          validator: (v) => v!.isEmpty ? "Informe o nome" : null,
                        ),
                        const SizedBox(height: 16),

                        // Email
                        TextFormField(
                          controller: emailCtrl,
                          decoration: InputDecoration(
                            hintText: "E-mail",
                            hintStyle: GoogleFonts.inter(color: Colors.grey.shade500),
                            prefixIcon: const Icon(Icons.email_outlined, color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                          validator: (v) => v!.isEmpty ? "Informe o email" : null,
                        ),
                        const SizedBox(height: 16),

                        // Senha
                        TextFormField(
                          controller: passCtrl,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Senha",
                            hintStyle: GoogleFonts.inter(color: Colors.grey.shade500),
                            prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                          validator: (v) => v!.isEmpty ? "Informe a senha" : null,
                        ),
                        const SizedBox(height: 16),

                        // Confirmar Senha
                        TextFormField(
                          controller: confirmPassCtrl,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Confirmar senha",
                            hintStyle: GoogleFonts.inter(color: Colors.grey.shade500),
                            prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                          validator: (v) {
                            if (v!.isEmpty) return "Confirme a senha";
                            if (v != passCtrl.text) return "As senhas não coincidem";
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),

                        // Botão Criar Conta
                        SizedBox(
                          width: double.infinity,
                          child: isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.green,
                                  ),
                                )
                              : ElevatedButton(
                                  onPressed: () async {
                                    if (!_formKey.currentState!.validate()) return;

                                    setState(() => isLoading = true);

                                    final ok = await AuthService().register(
                                      name: nameCtrl.text,
                                      email: emailCtrl.text,
                                      password: passCtrl.text,
                                    );

                                    setState(() => isLoading = false);

                                    if (ok) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text("Conta criada com sucesso!")),
                                      );
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text("Erro ao registrar")),
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green.shade500,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text(
                                    "Criar Conta",
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                        ),
                        const SizedBox(height: 16),

                        // Link para login
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Já tem conta? ",
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                                );
                              },
                              child: Text(
                                "Entre aqui",
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: Colors.green.shade500,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Botão Voltar
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.arrow_back, size: 18, color: Colors.black87),
                      const SizedBox(width: 6),
                      Text(
                        "Voltar",
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
