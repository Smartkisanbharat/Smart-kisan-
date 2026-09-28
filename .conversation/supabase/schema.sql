-- Optional production persistence for Smart Kisan Bharat.
-- Apply this in the Supabase SQL editor before setting SUPABASE_URL and
-- SUPABASE_SERVICE_ROLE_KEY on the server.
create table if not exists public.app_state (
  id text primary key,
  payload jsonb not null,
  updated_at timestamptz not null default now()
);

alter table public.app_state enable row level security;

-- The Express server uses the service role key server-side. No public client
-- policy is created, so the application state remains private to the API.
create index if not exists app_state_updated_at_idx
  on public.app_state (updated_at desc);