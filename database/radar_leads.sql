-- Nexus Ops — Workflow 7 (Lead Radar) table
-- Run once in Supabase: SQL Editor -> New query -> paste -> Run

CREATE TABLE IF NOT EXISTS radar_leads (
    id SERIAL PRIMARY KEY,
    source TEXT NOT NULL,              -- freelancer | remotive | remoteok | jobicy
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

-- Block public API access; n8n connects as the postgres user and is not affected
ALTER TABLE radar_leads ENABLE ROW LEVEL SECURITY;
