import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  final title = TextEditingController();
  final instructions = TextEditingController();
  final description = TextEditingController();
  String? selectedCategory;
  final time = TextEditingController();
  bool isLoading = false;

  final categories = [
    'Italiana',
    'Brasileira',
    'Mexicana',
    'Asiática',
    'Francesa',
    'Espanhola',
    'Vegetariana',
    'Vegana',
    'Sobremesa',
    'Bebida',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.recipe != null) {
      title.text = widget.recipe!.title;
      description.text = widget.recipe!.description ?? "";
      selectedCategory = widget.recipe!.category;
      time.text = widget.recipe!.timeMinutes?.toString() ?? "";
      instructions.text = widget.recipe!.instructions ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.recipe == null ? "Nova Receita" : "Editar Receita",
          style: GoogleFonts.inter(
            color: Colors.black87,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        elevation: 0.5,
        leading: const BackButton(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nome da Receita
                Text(
                  "Nome da Receita *",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: title,
                  decoration: InputDecoration(
                    hintText: "Ex: Bolo de Chocolate",
                    hintStyle: GoogleFonts.inter(color: Colors.grey.shade400),
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
                  validator: (v) =>
                      v!.isEmpty ? "Informe o nome da receita" : null,
                ),
                const SizedBox(height: 20),

                // Categoria e Tempo
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Categoria *",
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1F2937),
                            ),
                          ),
                          const SizedBox(height: 8),
                          DropdownButtonFormField<String>(
                            value: selectedCategory,
                            hint: Text(
                              "Selecione",
                              style: GoogleFonts.inter(
                                color: Colors.grey.shade500,
                              ),
                            ),
                            items: categories
                                .map((cat) => DropdownMenuItem(
                                      value: cat,
                                      child: Text(cat),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() => selectedCategory = value);
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                            ),
                            validator: (v) =>
                                v == null ? "Selecione uma categoria" : null,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Tempo (min)",
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1F2937),
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: time,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "30",
                              hintStyle: GoogleFonts.inter(
                                color: Colors.grey.shade400,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Ingredientes
                Text(
                  "Ingredientes *",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: description,
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText:
                        "Digite cada ingrediente em uma linha\nEx:\n2 xicaras de farinha\n3 ovos\n1 xicara de açúcar",
                    hintStyle: GoogleFonts.inter(
                      color: Colors.grey.shade400,
                      fontSize: 13,
                    ),
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
                  validator: (v) =>
                      v!.isEmpty ? "Informe os ingredientes" : null,
                ),
                const SizedBox(height: 20),

                // Modo de Preparo
                Text(
                  "Modo de Preparo *",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: instructions,
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText: "Descreva o passo a passo do preparo...",
                    hintStyle: GoogleFonts.inter(
                      color: Colors.grey.shade400,
                    ),
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
                  validator: (v) =>
                      v!.isEmpty ? "Informe o modo de preparo" : null,
                ),
                const SizedBox(height: 32),

                // Botão Salvar
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

                            final newRecipe = Recipe(
                              id: widget.recipe?.id,
                              title: title.text,
                              description: description.text,
                              category: selectedCategory,
                              timeMinutes: int.tryParse(time.text) ?? 0,
                              instructions: instructions.text,
                              imageUrl:
                                  "https://source.unsplash.com/400x300/?food",
                            );

                            bool success = false;
                            if (widget.recipe == null) {
                              success = await RecipeService()
                                  .createRecipe(newRecipe);
                            } else {
                              success = await RecipeService().updateRecipe(
                                widget.recipe!.id!,
                                newRecipe,
                              );
                            }

                            setState(() => isLoading = false);

                            if (success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(widget.recipe == null
                                      ? "Receita criada com sucesso!"
                                      : "Receita atualizada com sucesso!"),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              // Retorna true se foi edição, para indicar ao detalhe que foi atualizado
                              Navigator.pop(context, widget.recipe != null ? true : null);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Erro ao salvar a receita"),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade500,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            widget.recipe == null
                                ? "Salvar Receita"
                                : "Atualizar Receita",
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    title.dispose();
    description.dispose();
    time.dispose();
    instructions.dispose();
    super.dispose();
  }
}
