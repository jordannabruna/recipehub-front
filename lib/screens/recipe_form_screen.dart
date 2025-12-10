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
  final title = TextEditingController();
  final desc = TextEditingController();
  final category = TextEditingController();
  final time = TextEditingController();
  final image = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.recipe != null) {
      title.text = widget.recipe!.title;
      desc.text = widget.recipe!.description;
      category.text = widget.recipe!.category;
      time.text = widget.recipe!.timeMinutes.toString();
      image.text = widget.recipe!.imageUrl;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
              Text(widget.recipe == null ? "Nova Receita" : "Editar Receita")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: title,
                decoration: const InputDecoration(labelText: "Título"),
                validator: (v) => v!.isEmpty ? "Informe o título" : null,
              ),
              TextFormField(
                controller: desc,
                decoration: const InputDecoration(labelText: "Descrição"),
                validator: (v) => v!.isEmpty ? "Informe a descrição" : null,
              ),
              TextFormField(
                controller: category,
                decoration: const InputDecoration(labelText: "Categoria"),
              ),
              TextFormField(
                controller: time,
                decoration: const InputDecoration(labelText: "Tempo (min)"),
              ),
              TextFormField(
                controller: image,
                decoration: const InputDecoration(labelText: "URL da Imagem"),
                validator: (v) => v!.isEmpty ? "Informe a imagem" : null,
              ),
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;

                  final newRecipe = Recipe(
                    id: widget.recipe?.id,
                    title: title.text,
                    description: desc.text,
                    category: category.text,
                    timeMinutes: int.tryParse(time.text) ?? 0,
                    imageUrl: image.text,
                  );

                  if (widget.recipe == null) {
                    await RecipeService().createRecipe(newRecipe);
                  } else {
                    await RecipeService()
                        .updateRecipe(widget.recipe!.id!, newRecipe);
                  }

                  Navigator.pop(context);
                },
                child: Text(widget.recipe == null ? "Salvar" : "Atualizar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
