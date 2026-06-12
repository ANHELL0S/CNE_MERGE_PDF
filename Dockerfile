# --- Etapa 1: Builder ---
# Usamos una imagen de Node para construir la aplicación
FROM node:20-alpine AS builder

WORKDIR /app

# Copiamos los archivos de dependencias y las instalamos
# Usamos bun porque el proyecto original tiene bun.lock [citation:1]
COPY package.json bun.lock ./
RUN bun install --frozen-lockfile

# Copiamos todo el código fuente y lo construimos
COPY . .
RUN bun build

# --- Etapa 2: Servidor ---
# Usamos una imagen ligera de Nginx para servir la aplicación
FROM nginx:alpine

# Este es el punto crucial. ¡Copiamos los archivos desde la carpeta 'public' del builder!
COPY --from=builder /app/public /usr/share/nginx/html

# Configuramos Nginx para manejar correctamente las rutas de una SPA
RUN echo 'server { \
    listen 80; \
    server_name localhost; \
    root /usr/share/nginx/html; \
    index index.html; \
    location / { \
        try_files $uri $uri/ /index.html; \
    } \
}' > /etc/nginx/conf.d/default.conf

# Puerto que Nginx usará internamente
EXPOSE 80