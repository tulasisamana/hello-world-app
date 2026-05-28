# Use official Node.js LTS image as base
FROM node:18-alpine

# Set working directory inside the container
WORKDIR /app

# Copy package files first (for better layer caching)
COPY package*.json ./

# Install dependencies (none in this case, but good practice)
RUN npm install --omit=dev

# Copy the rest of the application source code
COPY . .

# Expose the port the app runs on
EXPOSE 3000

# Define the command to run the app
CMD ["node", "app.js"]
