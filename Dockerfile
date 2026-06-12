# Usar Bun oficial
FROM oven/bun:latest AS builder

WORKDIR /app

# Copiar archivos de dependencias
COPY package.json bun.lock ./
RUN bun install

# Copiar el resto del código y construir
COPY . .
RUN bun run build

# Etapa de producción con Bun
FROM oven/bun:latest

WORKDIR /app

# Copiar los archivos construidos y dependencias
COPY --from=builder /app/public ./public
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./

# Variables de entorno
ENV PORT=3010
ENV HOST=0.0.0.0

# Exponer el puerto 3010
EXPOSE 3010

# Iniciar la aplicación en modo producción
CMD ["bun", "run", "serve", "--port", "3010", "--host", "0.0.0.0"]