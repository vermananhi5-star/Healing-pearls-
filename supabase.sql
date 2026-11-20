-- Run this in Supabase SQL Editor.
create table if not exists public.website_content (
  id integer primary key default 1 check (id = 1),
  content jsonb not null,
  updated_at timestamptz default now()
);
create table if not exists public.clinic_settings (
  id integer primary key default 1 check (id = 1),
  settings jsonb not null,
  updated_at timestamptz default now()
);
create table if not exists public.feedback (
  id uuid primary key default gen_random_uuid(),
  name text,
  rating integer not null check (rating between 1 and 5),
  message text not null check (char_length(message) between 5 and 1000),
  status text not null default 'pending' check (status in ('pending','approved','rejected')),
  is_featured boolean not null default false,
  created_at timestamptz not null default now()
);
alter table public.website_content enable row level security;
alter table public.clinic_settings enable row level security;
alter table public.feedback enable row level security;
-- Public may read website content/settings; only authenticated admins can write.
create policy "public read website content" on public.website_content for select using (true);
create policy "admins write website content" on public.website_content for all to authenticated using (true) with check (true);
create policy "public read clinic settings" on public.clinic_settings for select using (true);
create policy "admins write clinic settings" on public.clinic_settings for all to authenticated using (true) with check (true);
-- Public feedback insert only; public can read approved feedback only.
create policy "public submit feedback" on public.feedback for insert to anon, authenticated with check (status='pending' and is_featured=false);
create policy "public read approved feedback" on public.feedback for select using (status='approved');
create policy "admins manage feedback" on public.feedback for all to authenticated using (true) with check (true);
insert into public.website_content (id,content) values (1,'{"clinic_name":"HomeoCare Clinic","tagline":"Care • Wellness • Compassion","hero_title":"Care that listens. Wellness that matters.","hero_text":"A welcoming clinic focused on compassionate, patient-centred care.","about_title":"About our clinic","about_text":"We are committed to respectful communication and helping patients make informed decisions about their health.","doctor_name":"Dr. Your Doctor","qualifications":"Qualifications go here","mission":"Our mission is to provide a welcoming environment and clear health information.","logo_text":"✚","services":[{"name":"Consultation","description":"Patient-centred consultation and general health guidance."},{"name":"Wellness information","description":"Educational conversations about healthy routines and wellbeing."},{"name":"Follow-up support","description":"Follow-up discussions with your qualified healthcare professional."}]}') on conflict (id) do nothing;
insert into public.clinic_settings (id,settings) values (1,'{"phone":"[Phone]","whatsapp":"","email":"[Email]","address":"Your clinic address","hours":"[Opening hours]","map_embed":"","map_link":"","primary_color":"#477b62","footer":"© HomeoCare Clinic"}') on conflict (id) do nothing;
-- IMPORTANT: For production, restrict authenticated writes to a dedicated admin role.
-- This starter assumes the only Supabase Auth account you create is your owner admin.
