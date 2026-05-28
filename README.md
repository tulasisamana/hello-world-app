# Hello World – Automated Container Build Pipeline

A simple Node.js web app containerized with Docker and automatically built & pushed to Docker Hub via GitHub Actions.

---

## Project Structure

```
hello-world-app/
├── app.js                            # Node.js web server
├── package.json                      # App metadata
├── Dockerfile                        # Container build instructions
├── .dockerignore                     # Files excluded from Docker image
└── .github/
    └── workflows/
        └── docker-build.yml          # GitHub Actions CI/CD pipeline
```

---

## Running Locally

### Without Docker
```bash
node app.js
# Visit http://localhost:3000
```

### With Docker
```bash
# Build the image
docker build -t hello-world-app .

# Run the container
docker run -p 3000:3000 hello-world-app

# Visit http://localhost:3000
```

---

## GitHub Actions Setup

The workflow triggers on every push to `main`, builds the image, and pushes it to Docker Hub.

### Required GitHub Secrets

Go to **Settings → Secrets and variables → Actions** and add:

| Secret Name       | Value                        |
|-------------------|------------------------------|
| `DOCKER_USERNAME` | Your Docker Hub username     |
| `DOCKER_PASSWORD` | Your Docker Hub access token |

> **Tip:** Use a Docker Hub **Access Token** (not your password).  
> Create one at: https://hub.docker.com/settings/security

---

## Pipeline Flow

```
Push to main
     │
     ▼
GitHub Actions triggered
     │
     ├── Checkout code
     ├── Login to Docker Hub
     ├── Set up Docker Buildx
     └── Build & Push image
              │
              ▼
         Docker Hub
    yourusername/hello-world-app:latest
    yourusername/hello-world-app:<commit-sha>
```
