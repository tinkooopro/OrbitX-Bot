FROM node:18-slim

# Install Chromium and dependencies
RUN apt-get update && apt-get install -y \
    chromium \
    fonts-freefont-ttf \
    --no-install-recommends

# Set environment variables for Puppeteer
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

WORKDIR /app

# Create a directory for session data and give permissions
RUN mkdir -p /app/.wwebjs_auth && chmod -R 777 /app

COPY package*.json ./
RUN npm install
COPY . .

# Hugging Face Spaces typically run on port 7860
EXPOSE 7860

CMD ["node", "index.js"]
