# 使用 PHP 官方的基礎映像
FROM php:8.1-cli

# 安裝必要的 PHP 擴展和工具
RUN apt-get update && apt-get install -y \
    libzip-dev \
    zip \
    unzip \
    && docker-php-ext-install zip

# 安裝 Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# 將專案文件複製到容器中
COPY . /app
WORKDIR /app

# 安裝 PHP 依賴
RUN composer install

# 暴露應用的埠（如果有需要）
EXPOSE 80

# 設置啟動命令
CMD ["php", "bot.php"]
