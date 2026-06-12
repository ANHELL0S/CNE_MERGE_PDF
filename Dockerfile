# Build stage
FROM node:20-alpine AS builder

WORKDIR /app

# Habilitar yarn
RUN corepack enable && corepack prepare yarn@stable --activate

# Copiar dependencias
COPY package.json yarn.lock ./

# Instalar dependencias
RUN yarn install --frozen-lockfile

# Copiar código fuente
COPY . .

# Construir la aplicación
RUN yarn build

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