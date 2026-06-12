# --- Etapa 1: Builder ---
FROM node:20-alpine AS builder

WORKDIR /app

# Instalar Bun globalmente
RUN npm install -g bun

# Copiar archivos de dependencias
COPY package.json bun.lock ./
RUN bun install

# Copiar todo el código y construir
COPY . .
RUN bun run build

# --- Etapa 2: Servidor ---
FROM nginx:alpine

# Copiar los archivos construidos
COPY --from=builder /app/public /usr/share/nginx/html

# Configurar Nginx para escuchar en el puerto 3010
RUN echo 'server { \
    listen 3010; \
    server_name localhost; \
    root /usr/share/nginx/html; \
    index index.html; \
    location / { \
        try_files $uri $uri/ /index.html; \
    } \
}' > /etc/nginx/conf.d/default.conf

# Exponer el puerto 3010
EXPOSE 3010