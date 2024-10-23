# 使用官方 PHP 映像，這裡使用 PHP 8.1 作為範例
FROM php:8.1-cli

# 安裝必要的擴展和工具
RUN apt-get update && apt-get install -y \
    libzip-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd \
    && docker-php-ext-install zip \
    && docker-php-ext-install mbstring

# 安裝 Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# 設置工作目錄
WORKDIR /app

# 複製 composer.json 和 composer.lock 文件
COPY composer.json composer.lock ./

# 安裝 PHP 依賴
RUN composer install

# 複製應用程式代碼
COPY . .

# 設置容器啟動時執行的命令
CMD ["php", "bot.php"]
