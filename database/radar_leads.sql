-- Nexus Ops — Workflow 7 (Lead Radar) table
-- Run in Supabase: SQL Editor -> New query -> paste -> Run (safe to run again)

CREATE TABLE IF NOT EXISTS radar_leads (
    id SERIAL PRIMARY KEY,
    source TEXT NOT NULL,              -- freelancer, remotive, remoteok, jobicy, himalayas, workingnomads, arbeitnow, hackernews, weworkremotely, reddit_forhire
    external_id TEXT NOT NULL,         -- the post's ID on that site
    title TEXT,
    company TEXT,
    url TEXT,
    location TEXT,
    budget TEXT,
    description TEXT,
    posted_at TIMESTAMPTZ,
    score INTEGER,                     -- 0-100 from Groq
    fit TEXT,                          -- strong | partial | poor
    reason TEXT,
    suggested_pitch TEXT,
    status TEXT DEFAULT 'new',         -- new -> scored -> (you) applied / skipped
    created_at TIMESTAMPTZ DEFAULT now(),
    UNIQUE (source, external_id)       -- stops the same post being saved twice
);

-- Trust check columns (added later; safe if they already exist)
ALTER TABLE radar_leads ADD COLUMN IF NOT EXISTS client_info TEXT;   -- verification / reviews / company name
ALTER TABLE radar_leads ADD COLUMN IF NOT EXISTS trust TEXT;         -- high | medium | low (from Groq)

-- Block public API access; n8n connects as the postgres user and is not affected
ALTER TABLE radar_leads ENABLE ROW LEVEL SECURITY;
