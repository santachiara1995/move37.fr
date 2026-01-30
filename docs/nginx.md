# Guide NGINX (installation et usage)

Ce guide resume les bases pour installer NGINX, configurer un serveur web simple, puis l'utiliser comme reverse proxy.

## Installation

- Docs officielles : https://nginx.org/en/docs/

Exemples Linux (Debian/Ubuntu) :

```bash
sudo apt update
sudo apt install nginx
```

## Organisation de la configuration

- Fichier principal : `/etc/nginx/nginx.conf`
- Sites : `/etc/nginx/sites-available/` et `/etc/nginx/sites-enabled/`
- Logs : `/var/log/nginx/access.log`, `/var/log/nginx/error.log`

## Serveur statique simple

Exemple minimal :

```nginx
server {
  listen 80;
  server_name example.com;
  root /var/www/site;
  index index.html;
}
```

Recharger la config :

```bash
sudo nginx -t
sudo systemctl reload nginx
```

## Reverse proxy vers une app

```nginx
server {
  listen 80;
  server_name app.example.com;

  location / {
    proxy_pass http://127.0.0.1:3000;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
  }
}
```

## HTTPS (idee generale)

- Utiliser un certificat (ex. Let's Encrypt).
- Activer TLS dans le bloc `server`.

## Commandes utiles

```bash
sudo nginx -t
sudo systemctl status nginx
sudo systemctl reload nginx
```

## References

- https://nginx.org/en/docs/
- https://nginx.org/en/docs/beginners_guide.html
