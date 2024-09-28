FROM node:18-alpine

WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the app files
COPY . .

# Fix permissions (ensure the "node" user can access everything in /app and .next)
RUN chown -R node:node /app

# Switch to a non-root user
USER node

EXPOSE 3000

# Start Prisma migration and run the development server
CMD ["sh", "-c", "npx prisma db push && npm run dev"]
