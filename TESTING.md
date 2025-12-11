# 🧪 Guia de Testes - Sistema de Receitas

## ✅ Cenários de Teste

### **1. Autenticação e Navegação Principal**

#### Teste 1.1: Login e Acesso ao Feed
- [ ] Abra a aplicação
- [ ] Realize login com credenciais válidas
- [ ] Verifique se redirecionou para `MainScreen`
- [ ] Verifique se BottomNavigationBar está visível com 3 abas
- [ ] Primeira aba (Feed) deve estar ativa

#### Teste 1.2: Navegação entre Abas
- [ ] Clique em "Minhas Receitas" (aba 2)
- [ ] Verifique se mudou para `RecipeListScreen`
- [ ] Clique em "Perfil" (aba 3)
- [ ] Verifique se mudou para `ProfileScreen`
- [ ] Clique em "Feed" (aba 1)
- [ ] Verifique se voltou para `FeedScreen`

---

### **2. Feed Principal (Todas as Receitas)**

#### Teste 2.1: Carregar Lista de Receitas
- [ ] Na aba Feed, verifique se as receitas carregam
- [ ] Cada card deve exibir:
  - [x] Imagem da receita
  - [x] Avatar do autor (com gradiente)
  - [x] Nome do autor
  - [x] Link "Ver perfil"
  - [x] Título da receita
  - [x] Descrição resumida
  - [x] Categoria (tag)
  - [x] Tempo de preparo (ícone + tempo)

#### Teste 2.2: Pesquisa de Receitas
- [ ] Digite texto na barra de pesquisa
- [ ] Verifique se filtra receitas em tempo real
- [ ] Limpe a pesquisa
- [ ] Verifique se volta a mostrar todas

#### Teste 2.3: Pull-to-Refresh
- [ ] Puxe a lista para baixo (no topo)
- [ ] Verifique se mostra indicador de loading
- [ ] Verifique se recarrega a lista

#### Teste 2.4: Clique no Autor
- [ ] Clique no nome do autor ou avatar
- [ ] Verifique se navega para `UserProfileScreen`
- [ ] Verifique se exibe receitas daquele usuário
- [ ] Pressione voltar

#### Teste 2.5: Clique na Receita
- [ ] Clique em qualquer receita
- [ ] Verifique se navega para `RecipeDetailScreen`
- [ ] Verifique os detalhes (título, descrição, ingredientes, modo de preparo)
- [ ] Se NÃO for sua receita:
  - [ ] Deve mostrar card com info do autor
  - [ ] Botões de editar/deletar NÃO devem aparecer
  - [ ] Clique "Ver perfil" deve levar ao perfil do autor

---

### **3. Minhas Receitas**

#### Teste 3.1: Listar Receitas do Usuário
- [ ] Clique em "Minhas Receitas"
- [ ] Verifique se exibe APENAS suas receitas
- [ ] Cada card deve exibir:
  - [x] Imagem
  - [x] Título
  - [x] Categoria
  - [x] Tempo
  - [x] Botão "Editar" (cor laranja)
  - [x] Botão "Deletar" (cor vermelha)

#### Teste 3.2: Pesquisa
- [ ] Digite nome de uma receita
- [ ] Verifique se filtra

#### Teste 3.3: Criar Nova Receita
- [ ] Clique no botão flutuante (+)
- [ ] Preencha os dados
- [ ] Clique "Salvar"
- [ ] Verifique se volta para a lista
- [ ] Verifique se a nova receita aparece

#### Teste 3.4: Editar Receita
- [ ] Clique no botão "Editar" de uma receita
- [ ] Verifique se abre `RecipeFormScreen` com dados pré-preenchidos
- [ ] Modifique algum campo
- [ ] Clique "Salvar"
- [ ] Verifique se volta para a lista
- [ ] Verifique se a receita foi atualizada

#### Teste 3.5: Deletar Receita
- [ ] Clique no botão "Deletar"
- [ ] Verifique se exibe diálogo de confirmação
- [ ] Clique "Cancelar"
- [ ] Verifique se não deleta
- [ ] Clique "Deletar" novamente
- [ ] Clique "Deletar" (confirmação)
- [ ] Verifique se exibe SnackBar de sucesso
- [ ] Verifique se a receita desaparece da lista

---

### **4. Perfil de Usuário (Público)**

#### Teste 4.1: Acessar Perfil de Outro Usuário
- [ ] No Feed, clique no autor de uma receita
- [ ] Verifique se abre `UserProfileScreen`
- [ ] Dados esperados:
  - [x] Avatar do usuário
  - [x] Nome completo
  - [x] Número de receitas
  - [x] Lista de receitas (formato compacto)

#### Teste 4.2: Receitas do Perfil
- [ ] Verifique se exibe as receitas daquele usuário
- [ ] Clique em uma receita
- [ ] Verifique se abre detalhes
- [ ] Verifique se há card "Ver perfil" (já está naquele perfil)
- [ ] Pressione voltar

#### Teste 4.3: Nenhuma Receita
- [ ] Procure um usuário sem receitas (se houver)
- [ ] Verifique mensagem "Nenhuma receita compartilhada"

---

### **5. Detalhes da Receita**

#### Teste 5.1: Receita de Outro Usuário
- [ ] Abra uma receita que NÃO é sua
- [ ] Verifique:
  - [x] Card com info do autor (avatar, nome, "Ver perfil")
  - [x] Título da receita
  - [x] Categoria e tempo
  - [x] Ingredientes
  - [x] Modo de Preparo
  - [x] Botões editar/deletar NÃO aparecem na appBar

#### Teste 5.2: Clique "Ver Perfil" do Autor
- [ ] Na receita de outro usuário, clique "Ver perfil"
- [ ] Verifique se navega para o perfil daquele usuário

#### Teste 5.3: Sua Receita
- [ ] Vá para "Minhas Receitas"
- [ ] Clique em uma receita
- [ ] Verifique:
  - [x] Card do autor NÃO aparece (é você mesmo)
  - [x] Botão "Editar" (ícone de lápis) na appBar
  - [x] Botão "Deletar" (ícone de lixo) na appBar

#### Teste 5.4: Editar da Tela de Detalhes
- [ ] Na sua receita, clique "Editar"
- [ ] Modifique algum campo
- [ ] Clique "Salvar"
- [ ] Verifique se volta para detalhes com dados atualizados

#### Teste 5.5: Deletar da Tela de Detalhes
- [ ] Na sua receita, clique "Deletar"
- [ ] Verifique diálogo de confirmação
- [ ] Clique "Deletar"
- [ ] Verifique se volta para a lista anterior
- [ ] Verifique SnackBar de sucesso

---

### **6. Seu Perfil Pessoal**

#### Teste 6.1: Abrir Seu Perfil
- [ ] Clique em "Perfil" (aba 3)
- [ ] Verifique:
  - [x] Avatar com gradiente
  - [x] Nome completo
  - [x] Email
  - [x] Total de receitas
  - [x] Membro desde

#### Teste 6.2: Logout
- [ ] Clique no botão "Sair"
- [ ] Verifique se volta para `LoginScreen`
- [ ] Tente fazer login novamente

---

### **7. Fluxos Completos**

#### Fluxo 1: Descobrir Nova Receita
```
Feed → Pesquisa → Encontra receita → Clica
→ Vê detalhes → Clica no autor → Vê perfil do autor
→ Volta para feed → Navega entre abas
```

#### Fluxo 2: Criar e Gerenciar Receita
```
Minhas Receitas → Clica (+) → Cria receita
→ Salva → Lista atualiza → Edita receita
→ Salva → Detalhes mostram atualizado
→ Volta para Minhas Receitas → Deleta com confirmação
```

#### Fluxo 3: Seguir Usuário (Sugestão Futura)
```
Feed → Vê receita interessante → Clica no autor
→ Vê perfil → "Seguir" (futura feature)
```

---

## 🐛 Casos de Erro Esperados

### **Teste E1: Sem Conectividade**
- [ ] Desligue internet
- [ ] Tente carregar Feed
- [ ] Verifique mensagem de erro apropriada

### **Teste E2: Receita Deletada**
- [ ] Um usuário deleta uma receita
- [ ] Outro tenta acessar a URL/details
- [ ] Verifique erro apropriado

### **Teste E3: Usuário Deletado**
- [ ] Um usuário é deletado
- [ ] Outro tenta acessar seu perfil
- [ ] Verifique erro apropriado

---

## 📊 Dados de Teste Sugeridos

### **Usuário 1**
- Email: `user1@test.com`
- Senha: `123456`
- Receitas: 3-5

### **Usuário 2**
- Email: `user2@test.com`
- Senha: `123456`
- Receitas: 2-4

### **Receita Teste**
```
Título: "Bolo de Chocolate"
Descrição: "Bolo fofinho"
Ingredientes: "Farinha, Açúcar, Ovos"
Modo de Preparo: "Misture tudo e leve ao forno"
Tempo: 45
Categoria: "Sobremesa"
```

---

## ✨ Performance e UI

### **Teste P1: Carregamento**
- [ ] Feed com muitas receitas carrega suavemente
- [ ] Sem travamentos ou lags

### **Teste P2: Responsividade**
- [ ] Teste em diferentes tamanhos de tela
- [ ] Tablets
- [ ] Paisagem/Retrato

### **Teste P3: Feedback Visual**
- [ ] Loading spinners aparecem
- [ ] SnackBars mostram mensagens
- [ ] Botões têm feedback (ripple effect)

---

## 📋 Checklist Final

- [ ] Login/Logout funciona
- [ ] BottomNavigationBar funciona com 3 abas
- [ ] Feed exibe todas as receitas
- [ ] Pesquisa filtra receitas
- [ ] Pull-to-refresh recarrega
- [ ] Clique em autor vai para perfil dele
- [ ] Clique em receita mostra detalhes
- [ ] Minhas Receitas exibe só suas receitas
- [ ] Botão (+) cria nova receita
- [ ] Editar receita funciona
- [ ] Deletar receita com confirmação funciona
- [ ] Perfil público mostra receitas do usuário
- [ ] Receita de outro mostra "Ver perfil" do autor
- [ ] Sua receita mostra botões editar/deletar
- [ ] Seu perfil mostra logout
- [ ] Mensagens de erro apropriadas
- [ ] Sem crashes ou exceções não tratadas

---

**Última atualização**: 11 de dezembro de 2025
