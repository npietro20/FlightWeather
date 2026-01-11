# Use an LTS Node image
FROM node:20-slim

# Create app directory
WORKDIR /app

# Copy dependency manifests first (better layer caching)
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production

# Copy the rest of the app
COPY . .

# Fly sets PORT at runtime; app must listen on it
ENV NODE_ENV=production

# Expose is optional for Fly but fine to include
EXPOSE 8080

# Start your server
CMD ["node", "server.js"]