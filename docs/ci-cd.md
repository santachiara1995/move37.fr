# Guide CI/CD (GitHub Actions) : dev local -> PR -> production

Objectif : travailler depuis votre laptop, pousser une branche, ouvrir une PR, valider les checks sur GitHub, puis deployer en production automatiquement apres merge.

## Flux recommande

1) Creer une branche locale
```bash
git checkout -b feature/ma-feature
```

2) Coder et committer
```bash
git add .
git commit -m "feat: ma feature"
```

3) Push et ouvrir une PR
```bash
git push -u origin feature/ma-feature
```

4) Verifier les checks dans l'onglet PR (GitHub UI)

5) Merge dans `main` (ou `master`) une fois les checks verts

6) Deploiement automatique vers la production

## CI : verifier les PR

Exemple de workflow `ci.yml` (tests + lint) :

```yaml
name: CI
on:
  pull_request:
    branches: ["main"]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: 20
      - run: npm ci
      - run: npm test
      - run: npm run lint
```

## CD : deploy apres merge

Exemple de workflow `cd.yml` (trigger sur push main) :

```yaml
name: CD
on:
  push:
    branches: ["main"]

jobs:
  deploy:
    runs-on: ubuntu-latest
    environment: production
    steps:
      - uses: actions/checkout@v4
      - run: ./scripts/deploy.sh
        env:
          SSH_HOST: ${{ secrets.SSH_HOST }}
          SSH_USER: ${{ secrets.SSH_USER }}
          SSH_KEY: ${{ secrets.SSH_KEY }}
```

## Parametres GitHub recommandes

- Branch protection sur `main`
  - Required status checks (ex. `CI`)
  - Require PR before merge
- Environments (production) avec approvals si besoin
- Secrets pour deploy (SSH, API keys, registry token)

## Strategie de deploiement (exemples)

- SSH + script (redemarre un service, met a jour une image Docker)
- Registry + pull d'image taggee
- Plateforme (Render, Fly.io, AWS, GCP) via CLI

## Comment valider sur GitHub

- Ouvrir la PR
- Verifier que tous les checks sont verts
- Resoudre les commentaires de review
- Merger (squash ou merge commit selon votre policy)

## References

- https://docs.github.com/en/actions
- https://docs.github.com/en/actions/using-workflows
