# Build stage
FROM oven/bun:latest AS builder

WORKDIR /app

# Limpiar caché de Bun primero
RUN bun cache clean

# Copiar solo package.json
COPY package.json ./

# Instalar con flag para limpiar caché
RUN bun install --force

# Copiar código fuente
COPY . .

# Limpiar caché de Gatsby y construir
RUN rm -rf .cache public && bun run build

# Production stage
FROM nginx:alpine

# Copiar los archivos estáticos generados
COPY --from=builder /app/public /usr/share/nginx/html

# Configurar Nginx para puerto 3010
RUN echo 'server { \
    listen 3010; \
    server_name localhost; \
    root /usr/share/nginx/html; \
    index index.html; \
    location / { \
        try_files $uri $uri/ /index.html; \
    } \
    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg)$ { \
        expires 1y; \
        add_header Cache-Control "public, immutable"; \
    } \
}' > /etc/nginx/conf.d/default.conf

EXPOSE 3010