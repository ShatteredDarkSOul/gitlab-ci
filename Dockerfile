# Menggunakan base image PM2 sesuai labsheet
FROM keymetrics/pm2:10-alpine

# Update dan instal tools pendukung
RUN apk update && apk upgrade && \
    apk add --no-cache \
    bash \
    git \
    curl \
    openssh

# Label pembuat
MAINTAINER Zulfadhli Ahnaf

# Buat direktori aplikasi
RUN mkdir -p /usr/src/apps
WORKDIR /usr/src/apps

# Instal dependensi (Copy package.json dulu agar build cache efisien)
COPY package.json ./
RUN npm cache clean --force
RUN npm install

# Copy seluruh source code
COPY . .

# Ekspos port 3000
EXPOSE 3000

# Jalankan aplikasi menggunakan PM2 runtime
CMD [ "pm2-runtime", "start", "pm2.json", "--env", "production"]
