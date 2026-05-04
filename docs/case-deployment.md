# Case Deployment

Case serves the Neuromancer React app from `/var/www/neuromancer-page` using Caddy.

## Manual deploy on Case

```bash
cd /opt/neuromancer-page
./scripts/deploy-case.sh
```

The deploy script:

1. pulls `main` from GitHub
2. runs `npm ci`
3. builds with server-root asset paths using `npm run build:server`
4. publishes `dist/` to `/var/www/neuromancer-page`
5. reloads Caddy
6. verifies the local HTTP response and JS bundle

## Build modes

- `npm run build:github` builds for GitHub Pages at `/neuromancer-page/`
- `npm run publish:github` builds for GitHub Pages and copies the static artifact into the repository root for branch-based Pages hosting
- `npm run build:server` builds for a root-mounted server like Case at `/`
- `npm run deploy:case` runs the Case deployment script from the server
