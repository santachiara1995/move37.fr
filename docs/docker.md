# Guide Docker (local -> prod)

Ce guide explique comment utiliser Docker pour lancer des services en local, construire des images, puis preparer un flux de deploiement reproductible.

## Prerequis

- Docker Desktop (Windows/macOS) ou Docker Engine (Linux)
- Acces a un registry (ex. Docker Hub, GHCR) si vous poussez des images

## Notions essentielles

- Image : modele immuable d'une application.
- Conteneur : instance d'une image en execution.
- Registry : depot d'images.
- Volume : stockage persistant.

## Installation rapide

- Docs officielles : https://docs.docker.com/get-started/

Verifiez :

```bash
docker --version
docker run hello-world
```

## Lancer un service en local

```bash
docker run --name web -p 8080:80 -d nginx:latest
```

- Ouvrir http://localhost:8080
- Arreter : `docker stop web`
- Supprimer : `docker rm web`

## Construire une image

Exemple de `Dockerfile` :

```dockerfile
FROM node:20-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
EXPOSE 3000
CMD ["npm","start"]
```

Construire et lancer :

```bash
docker build -t mon-app:1.0 .
docker run -p 3000:3000 mon-app:1.0
```

## Volumes (donnees persistantes)

```bash
docker run -v data:/var/lib/postgresql/data -d postgres:16
```

## Docker Compose (multi-services)

`docker-compose.yml` minimal :

```yaml
services:
  app:
    build: .
    ports:
      - "3000:3000"
  redis:
    image: redis:7
```

Lancer :

```bash
docker compose up -d
```

## Nettoyage

```bash
docker ps
docker images
docker system prune
```

## Conseils pour la prod

- Taggez vos images avec un numero de version et un SHA.
- Scannez vos images (ex. `docker scout`, `trivy`).
- Utilisez des images de base minimalistes (alpine, distroless).

## References

- https://docs.docker.com/get-started/
- https://docs.docker.com/engine/reference/commandline/docker/
