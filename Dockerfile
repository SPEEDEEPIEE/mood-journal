# Stage 1: сборка
FROM node:18 AS builder
WORKDIR /app

# Копируем все файлы проекта
COPY package*.json ./
COPY vite.config.js ./
COPY index.html ./
COPY src ./src
COPY public ./public

# Устанавливаем зависимости
RUN npm ci

# Собираем проект
RUN npm run build 

# Stage 2: лёгкий сервер
FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
