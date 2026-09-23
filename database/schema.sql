-- Nexus Ops — Database Schema (Supabase / PostgreSQL)

-- One row per contact
CREATE TABLE leads (
    id SERIAL PRIMARY KEY,
    contact_id TEXT UNIQUE NOT NULL,
    contact_name TEXT,
    channel TEXT NOT NULL,
    status TEXT DEFAULT 'new',
    intent TEXT,
    urgency TEXT,
    lead_score INTEGER,
    created_at TIMESTAMPTZ DEFAULT now(),
    last_contacted_at TIMESTAMPTZ DEFAULT now()
);

-- Every inbound/outbound message, linked to its lead
CREATE TABLE conversations (
    id SERIAL PRIMARY KEY,
    lead_id INTEGER REFERENCES leads(id),
    direction TEXT NOT NULL,
    channel TEXT NOT NULL,
    message TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT now()
);

-- Audit log of every AI classification
CREATE TABLE ai_decisions (
    id SERIAL PRIMARY KEY,
    lead_id INTEGER REFERENCES leads(id),
    intent TEXT,
    urgency TEXT,
    lead_score INTEGER,
    raw_prompt TEXT,
    raw_response TEXT,
    created_at TIMESTAMPTZ DEFAULT now()
);

-- Roadmap: human approval queue for high-risk leads (Workflow 6)
CREATE TABLE approval_queue (
    id SERIAL PRIMARY KEY,
    lead_id INTEGER REFERENCES leads(id),
    conversation_id INTEGER REFERENCES conversations(id),
    lead_score INTEGER,
    urgency TEXT,
    intent TEXT,
    message TEXT,
    contact_name TEXT,
    status TEXT DEFAULT 'pending',
    reviewed_at TIMESTAMPTZ,
    reviewed_by TEXT,
    approval_notes TEXT,
    created_at TIMESTAMPTZ DEFAULT now()
);-- Nexus Ops — Database Schema (Supabase / PostgreSQL)

-- One row per contact
CREATE TABLE leads (
    id SERIAL PRIMARY KEY,
    contact_id TEXT UNIQUE NOT NULL,
    contact_name TEXT,
    channel TEXT NOT NULL,
    status TEXT DEFAULT 'new',
    intent TEXT,
    urgency TEXT,
    lead_score INTEGER,
    created_at TIMESTAMPTZ DEFAULT now(),
    last_contacted_at TIMESTAMPTZ DEFAULT now()
);

-- Every inbound/outbound message, linked to its lead
CREATE TABLE conversations (
    id SERIAL PRIMARY KEY,
    lead_id INTEGER REFERENCES leads(id),
    direction TEXT NOT NULL,
    channel TEXT NOT NULL,
    message TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT now()
);

-- Audit log of every AI classification
CREATE TABLE ai_decisions (
    id SERIAL PRIMARY KEY,
    lead_id INTEGER REFERENCES leads(id),
    intent TEXT,
    urgency TEXT,
    lead_score INTEGER,
    raw_prompt TEXT,
    raw_response TEXT,
    created_at TIMESTAMPTZ DEFAULT now()
);

-- Roadmap: human approval queue for high-risk leads (Workflow 6)
CREATE TABLE approval_queue (
    id SERIAL PRIMARY KEY,
    lead_id INTEGER REFERENCES leads(id),
    conversation_id INTEGER REFERENCES conversations(id),
    lead_score INTEGER,
    urgency TEXT,
    intent TEXT,
    message TEXT,
    contact_name TEXT,
    status TEXT DEFAULT 'pending',
    reviewed_at TIMESTAMPTZ,
    reviewed_by TEXT,
    approval_notes TEXT,
    created_at TIMESTAMPTZ DEFAULT now()
);