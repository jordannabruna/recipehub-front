# RecipeHub Frontend

Aplicação Flutter web para gerenciar receitas.

## 🚀 Deployment no Render

### Pré-requisitos
- Conta no Render (render.com)
- Repositório GitHub conectado

### Passos para Deploy

1. **Acesse o Render**
   - Vá para https://dashboard.render.com
   - Clique em "New +" e selecione "Web Service"

2. **Conecte o repositório**
   - Selecione o repositório `recipehub-front`
   - Defina a branch como `main`

3. **Configure o serviço**
   - **Name**: `recipehub-frontend`
   - **Runtime**: Docker
   - **Region**: Escolha a mais próxima
   - **Branch**: main

4. **Variáveis de Ambiente** (se necessário)
   - `API_BASE_URL`: https://recipehub-back.onrender.com
   - `NODE_ENV`: production

5. **Build & Deploy**
   - Render detectará o Dockerfile automaticamente
   - Clique em "Deploy" para iniciar o build

6. **Aguarde o deploy**
   - Você receberá um URL como: `https://recipehub-frontend.onrender.com`

## 🧪 Testes Locais

### Com Docker Compose
```bash
docker-compose up --build
```

Acesse em: http://localhost:8080

### Com Flutter CLI
```bash
flutter pub get
flutter run -d web-server --web-port 8080
```

## 📝 Configuração

A API base está configurada em `lib/config/constants.dart`:
```dart
static const String apiBaseUrl = 'https://recipehub-back.onrender.com';
```

## ✅ Credenciais de Teste

- **Email**: jordanabruna90@gmail.com
- **Password**: senha123

## 🔗 Links

- **Frontend**: https://recipehub-frontend.onrender.com (após deploy)
- **Backend**: https://recipehub-back.onrender.com
- **GitHub**: https://github.com/jordannabruna/recipehub-front

## 📞 Suporte

Para problemas de deploy, verifique os logs no Render dashboard.
