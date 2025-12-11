# Build stage
FROM ghcr.io/cirruslabs/flutter:latest as builder

WORKDIR /app

# Copiar arquivos do projeto
COPY . .

# Instalar dependências e fazer build da versão web
RUN flutter pub get
RUN flutter build web --release

# Serve stage
FROM node:18-alpine

WORKDIR /app

# Instalar serve para servir arquivos estáticos
RUN npm install -g serve

# Copiar arquivos built do stage anterior
COPY --from=builder /app/build/web ./build/web

# Expor porta
EXPOSE 8080

# Comando para rodar
CMD ["serve", "-s", "build/web", "-l", "8080"]
