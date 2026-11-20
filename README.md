# Homeopathic Clinic Website — Cloudflare Pages + Supabase

## Files
- `index.html`: public website
- `admin.html`: owner dashboard (Supabase Auth)
- `app.js`: app logic and configuration
- `style.css`: responsive styles
- `supabase.sql`: tables, starter content and row-level security

## Setup (free tiers may have limits)
1. Create a Supabase project.
2. In Supabase SQL Editor, run `supabase.sql`.
3. In Supabase Authentication, create your own admin user (email + strong password). Do not enable public sign-up.
4. Copy Project URL and anon/public key from Project Settings → API.
5. Open `app.js` and replace `YOUR_SUPABASE_URL` and `YOUR_SUPABASE_ANON_KEY`.
6. Upload the project files to a GitHub repository.
7. In Cloudflare Dashboard → Workers & Pages → Create → Pages → Connect to Git. Select repo. Framework preset: None; build command: blank; output directory: `/` (or project root as configured). Deploy.
8. Open `/admin.html`, sign in and edit website content/settings. Public feedback goes into Pending and is not displayed until approved.

## Images
Use public image URLs in the editor initially. For private uploads, set up a Supabase Storage bucket and policies; the current editor accepts image URLs and does not implement file upload yet.

## Security notes
- Supabase RLS policies in this starter allow any authenticated account to write. **Only create the owner's account and keep sign-up disabled.** For a production clinic, tighten policies with an admin-role table/claim before inviting any other users.
- Public users can insert pending feedback and read approved feedback. They cannot update or delete feedback.
- The form includes a honeypot field. This is basic spam protection, not a CAPTCHA.
- Don't collect patient medical details or use feedback as medical advice.
- Replace all placeholders and test on mobile before publishing.

## Domain
Cloudflare Pages project → Custom domains → add your domain. A `.com` domain is usually paid separately; Cloudflare Pages hosting can be on a free tier.
