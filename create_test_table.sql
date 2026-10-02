-- Create a schema and a table in PostgreSQL
-- Adjust schema name, table name, and column definitions as needed.

CREATE SCHEMA IF NOT EXISTS app;

CREATE TABLE IF NOT EXISTS app.users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    full_name VARCHAR(255),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Optional example of adding a simple index
CREATE INDEX IF NOT EXISTS idx_app_users_email ON app.users (email);
