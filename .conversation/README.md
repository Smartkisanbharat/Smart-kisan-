# Smart Kisan Bharat

Production PWA and Express API for the Smart Kisan Bharat farmer-to-buyer marketplace.

## Run

```bash
pnpm install --frozen-lockfile
pnpm run build
pnpm start
```

The production server binds to `0.0.0.0:3000`.

Vercel uses `vercel.json`, `pnpm-lock.yaml`, and the same `pnpm run build`
command. The Vite frontend is emitted to `dist`; `api/index.js` exposes the
Express API as a serverless function.

## Persistence

- Local persistence uses atomic writes to `data/db.json`.
- If `SUPABASE_URL` and `SUPABASE_SERVICE_ROLE_KEY` are configured, the server hydrates from and synchronizes to the private `app_state` table.
- Apply `supabase/schema.sql` before enabling Supabase persistence.
- Set `PII_HASH_SALT` through Replit Secrets for production. It is never returned by an API.

## Privacy boundary

- Public listing responses only contain block/district location, not exact addresses.
- Farmer and buyer identities are generalized to verified roles.
- GST/PAN values are stored as hashes plus masked display values.
- Admin credentials are compared against one-way hashes and never stored in `data/db.json`.
- Admin metrics require a bearer session.
- SSE event payloads are sanitized before they are sent to clients.