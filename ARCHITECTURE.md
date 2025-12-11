# 📂 Estrutura de Telas - Sistema de Receitas

## 🎯 Fluxo de Navegação

```
LoginScreen
    ↓
    ↓ (Login bem-sucedido)
    ↓
MainScreen (BottomNavigationBar)
    ├─ Tab 1: FeedScreen
    │  ├─ getRecipes() [GET /recipes] → Todas as receitas
    │  ├─ RecipeCard
    │  │  ├─ Clique na receita → RecipeDetailScreen
    │  │  └─ Clique no autor → UserProfileScreen
    │  └─ Pesquisa em tempo real
    │
    ├─ Tab 2: RecipeListScreen (Minhas Receitas)
    │  ├─ getMyRecipes() [GET /recipes/me/my-recipes] → Suas receitas
    │  ├─ RecipeCard com Editar/Deletar
    │  ├─ Botão "+" → RecipeFormScreen (criar)
    │  └─ Sincronização automática
    │
    └─ Tab 3: ProfileScreen
       ├─ Dados do usuário logado
       └─ Logout button
```

---

## 📄 Telas e Componentes

### **Telas Principais**

#### 1. **FeedScreen** ✨ (NOVO)
- **Arquivo**: `lib/screens/feed_screen.dart`
- **Função**: Feed principal com todas as receitas
- **Dados**: GET `/recipes`
- **Componentes**:
  - AppBar com "RecipeHub"
  - Barra de pesquisa
  - ListView de RecipeCards
  - Pull-to-refresh
- **Navegação**:
  - Clique em receita → `RecipeDetailScreen`
  - Clique no autor → `UserProfileScreen`

#### 2. **RecipeListScreen** (REFATORADO)
- **Arquivo**: `lib/screens/recipe_list_screen.dart`
- **Função**: Minhas Receitas do usuário
- **Dados**: GET `/recipes/me/my-recipes`
- **Componentes**:
  - AppBar com "Minhas Receitas"
  - Barra de pesquisa
  - ListView de RecipeCards com ações
  - Botão flutuante (+) para criar
- **Ações**:
  - ✏️ Editar → `RecipeFormScreen`
  - 🗑️ Deletar com confirmação
  - ➕ Criar → `RecipeFormScreen`

#### 3. **UserProfileScreen** ✨ (NOVO)
- **Arquivo**: `lib/screens/user_profile_screen.dart`
- **Função**: Perfil público de qualquer usuário
- **Dados**: GET `/recipes/user/{user_id}`
- **Componentes**:
  - Avatar do usuário
  - Nome do usuário
  - Estatísticas (n° de receitas)
  - ListView de receitas (modo compacto)
- **Restrições**:
  - ❌ Sem botões de editar/deletar
  - ❌ Sem logout

#### 4. **RecipeDetailScreen** (REFATORADO)
- **Arquivo**: `lib/screens/recipe_detail_screen.dart`
- **Função**: Detalhes completos da receita
- **Dados**: GET `/recipes/{recipe_id}`
- **Lógica Condicional**:
  - **Se FOR sua receita**:
    - ✏️ Botão Editar
    - 🗑️ Botão Deletar
  - **Se NÃO for sua receita**:
    - 👤 Card com info do autor (nome, avatar)
    - 🔗 Botão "Ver perfil" → `UserProfileScreen`

#### 5. **ProfileScreen** (Existente)
- **Arquivo**: `lib/screens/profile_screen.dart`
- **Função**: Seu perfil pessoal
- **Componentes**:
  - Avatar e dados pessoais
  - Estatísticas
  - Logout button

#### 6. **MainScreen** ✨ (NOVO - Navegação)
- **Arquivo**: `lib/screens/main_screen.dart`
- **Função**: Container com BottomNavigationBar
- **Abas**:
  1. 🏠 Feed (FeedScreen)
  2. 📚 Minhas Receitas (RecipeListScreen)
  3. 👤 Perfil (ProfileScreen)

---

## 🔄 Fluxos de Dados

### **Buscar Receitas**
```
RecipeService.getRecipes()
  ↓
GET /recipes
  ↓
List<Recipe> (com ownerName, ownerProfileImage)
```

### **Buscar Minhas Receitas**
```
RecipeService.getMyRecipes()
  ↓
GET /recipes/me/my-recipes
  ↓
List<Recipe> (apenas do usuário logado)
```

### **Buscar Receitas do Usuário**
```
RecipeService.getUserRecipes(userId)
  ↓
GET /recipes/user/{userId}
  ↓
List<Recipe> (receitas públicas daquele usuário)
```

### **Deletar Receita**
```
RecipeService.deleteRecipe(id)
  ↓
DELETE /recipes/{id}
  ↓
bool (sucesso/erro)
  ↓
SnackBar com mensagem
  ↓
Reload list
```

---

## 🛡️ Proteções de Acesso

```dart
// Na RecipeDetailScreen
if (_currentUserId == recipe.ownerId) {
  // Mostrar Editar/Deletar
  showEditDeleteButtons();
} else {
  // Mostrar "Ver Perfil" do autor
  showAuthorCard();
}
```

---

## 📊 Model - Recipe

```dart
class Recipe {
  final int? id;
  final String title;
  final String? description;
  final String? instructions;
  final int? ownerId;              // ID do criador
  final String? category;
  final int? timeMinutes;
  final String? imageUrl;
  final String? mealType;
  
  // ✨ NOVOS CAMPOS
  final String? ownerName;          // Nome do criador
  final String? ownerProfileImage;  // Avatar do criador
}
```

---

## 🎨 Cores e Styling

- **Primária**: Orange `#FF6600`
- **Secundária**: Green `#10B981`
- **Fundo**: Light Gray `#F9FAFB`
- **Texto**: Dark Gray `#111827`
- **Bordas**: Light Gray `Colors.grey.shade200`

---

## 📱 Responsividade

- ✅ Adapta-se a diferentes tamanhos de tela
- ✅ Usa `Expanded` para widgets flexíveis
- ✅ Padding e margin consistentes
- ✅ Overflow tratado com `maxLines` e `overflow: TextOverflow.ellipsis`

---

## 🔧 Serviços Utilizados

| Serviço | Função |
|---------|--------|
| `AuthService` | Autenticação, obter dados do usuário |
| `RecipeService` | CRUD de receitas, buscar por filtros |
| `ApiClient` | Cliente HTTP com interceptadores |

---

## ✅ Checklist de Implementação

- [x] Feed principal (GET `/recipes`)
- [x] Minhas receitas (GET `/recipes/me/my-recipes`)
- [x] Perfil de usuário (GET `/recipes/user/{user_id}`)
- [x] Detalhes da receita (com verificação de proprietário)
- [x] Editar receita (apenas seu)
- [x] Deletar receita (apenas seu)
- [x] Criar receita
- [x] Navegação por abas (BottomNavigationBar)
- [x] Pesquisa de receitas
- [x] Clique em autor → Perfil
- [x] Feedback visual (SnackBars)
- [x] Confirmação de exclusão
- [x] Pull-to-refresh

---

**Última atualização**: 11 de dezembro de 2025
