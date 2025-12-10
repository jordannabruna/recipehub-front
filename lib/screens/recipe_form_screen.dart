import 'package:flutter/material.dart';
import '../models/recipe_model.dart';
import '../services/recipe_service.dart';

class RecipeFormScreen extends StatefulWidget {
  final Recipe? recipe;
  const RecipeFormScreen({super.key, this.recipe});

  @override
  State<RecipeFormScreen> createState() => _RecipeFormScreenState();
}

class _RecipeFormScreenState extends State<RecipeFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _ingredientsCtrl = TextEditingController(); // Usando description para ingredientes
  final _instructionsCtrl = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.recipe != null) {
      _titleCtrl.text = widget.recipe!.title;
      _ingredientsCtrl.text = widget.recipe!.description;
      _instructionsCtrl.text = widget.recipe!.instructions;
    }
  }

  void _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    final newRecipe = Recipe(
      id: widget.recipe?.id,
      title: _titleCtrl.text,
      description: _ingredientsCtrl.text,
      instructions: _instructionsCtrl.text,
    );

    bool success;
    if (widget.recipe == null) {
      success = await RecipeService().createRecipe(newRecipe);
    } else {
      success = await RecipeService().updateRecipe(widget.recipe!.id!, newRecipe);
    }

    setState(() => _isLoading = false);
    if (success && mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: Text(widget.recipe == null ? "Nova Receita" : "Editar Receita"),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildCard([
                _buildLabel("Nome da Receita *"),
                TextFormField(
                  controller: _titleCtrl,
                  decoration: _inputDeco("Ex: Bolo de Chocolate"),
                  validator: (v) => v!.isEmpty ? 'Obrigatório' : null,
                ),
                const SizedBox(height: 16),
                
                Row(
                  children: [
                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        _buildLabel("Categoria *"),
                        DropdownButtonFormField(
                          decoration: _inputDeco("Selecione"),
                          items: const [
                            DropdownMenuItem(value: "Geral", child: Text("Geral")),
                            DropdownMenuItem(value: "Doces", child: Text("Doces")),
                          ], 
                          onChanged: (v) {},
                          value: "Geral",
                        ),
                      ]),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        _buildLabel("Tempo (min)"),
                        TextFormField(
                          initialValue: "30",
                          decoration: _inputDeco("30"),
                          keyboardType: TextInputType.number,
                        ),
                      ]),
                    ),
                  ],
                )
              ]),
              const SizedBox(height: 16),

              _buildCard([
                _buildLabel("Ingredientes *"),
                TextFormField(
                  controller: _ingredientsCtrl,
                  maxLines: 5,
                  decoration: _inputDeco("Digite cada ingrediente em uma linha..."),
                  validator: (v) => v!.isEmpty ? 'Obrigatório' : null,
                ),
              ]),
              const SizedBox(height: 16),

              _buildCard([
                _buildLabel("Modo de Preparo *"),
                TextFormField(
                  controller: _instructionsCtrl,
                  maxLines: 5,
                  decoration: _inputDeco("Descreva o passo a passo..."),
                  validator: (v) => v!.isEmpty ? 'Obrigatório' : null,
                ),
              ]),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF10B981), // Verde
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: _isLoading 
                    ? const CircularProgressIndicator(color: Colors.white) 
                    : const Text("Salvar Receita", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF374151))),
    );
  }

  InputDecoration _inputDeco(String hint) {
    return InputDecoration(
      hintText: hint,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.grey.shade300)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: BorderSide(color: Colors.grey.shade300)),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    );
  }
}