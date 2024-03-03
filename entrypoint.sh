#!/bin/sh

# Make sure the output directory exists
mkdir -p /backend/out/bin

# Remove any existing build artifacts
rm -rf /backend/out/bin/*
rm -f backend
rm -rf dist/
rm -rf node_modules/

# Install backend dependencies
npm install

# Build the backend
npm run build

# Copy the node binary to the backend directory
cp $(command -v node) backend

# Create single executable preparation blob
node --experimental-sea-config sea-config.json

# Print the NodeJS version
echo "NodeJS Version: $(./backend --version)"

# Inject the preparation blob into the backend
npx --yes postject backend NODE_SEA_BLOB sea-prep.blob --sentinel-fuse NODE_SEA_FUSE_fce680ab2cc467b6e072b8b5df1996b2

# Copy the backend to the output directory
mv backend /backend/out/bin/
