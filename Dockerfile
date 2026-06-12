# Usar Bun oficial
FROM oven/bun:1.2.0 AS builder

WORKDIR /app

# Forzar que este build no use caché (solo para esta imagen)
RUN --no-cache=true rm -rf .cache node_modules

# Copiar archivos de dependencias
COPY package.json bun.lock ./
RUN --no-cache=true bun install --frozen-lockfile

# Copiar el resto del código
COPY . .

# Limpiar caché de Gatsby y construir
RUN --no-cache=true rm -rf .cache public
RUN --no-cache=true bun run build

# Etapa de producción
FROM oven/bun:1.2.0

WORKDIR /app
COPY --from=builder /app/public ./public
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./

ENV PORT=3010 HOST=0.0.0.0
EXPOSE 3010
CMD ["bun", "run", "serve", "--port", "3010", "--host", "0.0.0.0"]