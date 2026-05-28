# Assignment 1: Automated Container Build Pipeline

A simple Node.js "Hello World" web application containerized with Docker and automatically built and pushed to Docker Hub using GitHub Actions.

---

## Architecture

```
Developer (Local Machine)
        |
        | git push
        v
GitHub Repository (hello-world-app)
        |
        | triggers automatically on push to main
        v
GitHub Actions Pipeline
        |
        |-- Step 1: Checkout code
        |-- Step 2: Login to Docker Hub
        |-- Step 3: Setup Docker Buildx
        |-- Step 4: Build Docker image
        |-- Step 5: Push image to Docker Hub
        |
        v
Docker Hub (tulasisamana/hello-world-app)
        |
        | image available to pull and run anywhere
        v
Any Machine: docker run -p 3000:3000 tulasisamana/hello-world-app
```

---

## Tech Stack

| Layer | Technology |
|---|---|
| Application | Node.js (built-in http module) |
| Containerization | Docker |
| Base Image | node:20-slim |
| CI/CD Pipeline | GitHub Actions |
| Image Registry | Docker Hub |

---

## LLM Provider Used

**Claude (Anthropic)** was used to assist in building this project.

**Why Claude?**
- Provided step-by-step guidance for beginners with zero prior knowledge of Docker and GitHub Actions
- Generated all project files (Dockerfile, app.js, workflow YAML) with clear explanations
- Helped debug pipeline errors in real time (e.g. npm install failures, branch name mismatch)
- Explained concepts like containerization, CI/CD, and secrets management in simple language

---

## Setup Instructions

### Prerequisites
- Git installed on your machine
- GitHub account
- Docker Hub account

### 1. Clone the repository
```bash
git clone https://github.com/tulasisamana/hello-world-app.git
cd hello-world-app
```

### 2. Run locally (without Docker)
```bash
node app.js
# Visit http://localhost:3000
```

### 3. Run locally with Docker
```bash
docker build -t hello-world-app .
docker run -p 3000:3000 hello-world-app
# Visit http://localhost:3000
```

### 4. Pull from Docker Hub
```bash
docker pull tulasisamana/hello-world-app:latest
docker run -p 3000:3000 tulasisamana/hello-world-app:latest
```

### 5. Set up the CI/CD pipeline (for your own fork)
Add these two secrets in your GitHub repo under **Settings → Secrets and variables → Actions**:

| Secret Name | Value |
|---|---|
| `DOCKER_USERNAME` | Your Docker Hub username |
| `DOCKER_PASSWORD` | Your Docker Hub access token |

Every push to `main` will automatically build and push the image to Docker Hub.

---

## How the Pipeline Works

1. You push code to the `main` branch on GitHub
2. GitHub Actions is triggered automatically
3. It logs into Docker Hub using your stored secrets
4. It builds the Docker image using the `Dockerfile`
5. It pushes the image with two tags — `latest` and the commit SHA
6. The image is now available on Docker Hub for anyone to pull and run

---

## Known Limitations & Edge Cases

- **No HTTPS** — the app runs on plain HTTP. For production, a reverse proxy like Nginx with SSL would be needed.
- **Single port** — the app only listens on port 3000. The port is not configurable without editing the code.
- **No health check** — the Docker container has no health check defined, so orchestration tools like Kubernetes won't know if the app crashes inside the container.
- **No automated tests** — the pipeline builds and pushes without running any tests first. A test step should be added before the build step in production pipelines.
- **Public image** — the Docker Hub repository is public, meaning anyone can pull the image.
- **No multi-platform build** — the image is built only for the default platform (linux/amd64). It may not run natively on ARM-based machines (e.g. Apple M1/M2) without emulation.

---

## Project Structure

```
hello-world-app/
├── app.js                          # Node.js web server
├── package.json                    # App metadata (zero dependencies)
├── Dockerfile                      # Container build instructions
├── .dockerignore                   # Files excluded from image
├── README.md                       # This file
└── .github/
    └── workflows/
        └── docker-build.yml        # GitHub Actions CI/CD pipeline
```
