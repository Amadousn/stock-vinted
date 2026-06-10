-- =====================================================
--  STOCK VINTED — Setup Supabase
--  À coller dans : Supabase Dashboard > SQL Editor > New query > Run
-- =====================================================

-- 1. Table des articles
create table if not exists public.articles (
  id         uuid primary key default gen_random_uuid(),
  name       text not null,
  status     text not null default 'in',      -- 'in' = en stock, 'out' = épuisé
  img_url    text,
  created_at timestamptz not null default now()
);

-- 2. Activer le temps réel (synchro instantanée entre toi et ton transporteur)
alter publication supabase_realtime add table public.articles;

-- 3. Row Level Security : accès public (lien sans login)
--    ⚠️ Toute personne ayant le lien + la clé anon peut lire/modifier.
--    Garde l'URL Vercel privée.
alter table public.articles enable row level security;

drop policy if exists "public_all" on public.articles;
create policy "public_all" on public.articles
  for all using (true) with check (true);

-- 4. Bucket de stockage pour les photos (public)
insert into storage.buckets (id, name, public)
values ('photos', 'photos', true)
on conflict (id) do nothing;

-- 5. Policies du bucket : upload + lecture publics
drop policy if exists "photos_read"   on storage.objects;
drop policy if exists "photos_write"  on storage.objects;
drop policy if exists "photos_delete" on storage.objects;

create policy "photos_read"   on storage.objects
  for select using (bucket_id = 'photos');
create policy "photos_write"  on storage.objects
  for insert with check (bucket_id = 'photos');
create policy "photos_delete" on storage.objects
  for delete using (bucket_id = 'photos');

-- ✅ Terminé.
