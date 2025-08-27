# Use official Node.js image
FROM node:20

# Set working directory inside container
WORKDIR /app

# Copy package.json and package-lock.json first for caching
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the project files
COPY public/ ./public
COPY src/ ./src

# Expose port your app runs on
EXPOSE 3000

# Command to start the app
CMD ["npm", "start"]
