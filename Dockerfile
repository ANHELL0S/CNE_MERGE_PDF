# Build stage
FROM oven/bun:latest AS builder

WORKDIR /app

# Copiar dependencias
COPY package.json bun.lock ./

# Instalar dependencias con Bun
RUN bun install --frozen-lockfile

# Copiar código fuente
COPY . .

# Construir la aplicación
RUN bun run build

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