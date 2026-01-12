-- placeholder inicial (lo dejamos mínimo hoy)
CREATE TABLE IF NOT EXISTS _bootstrap (
  id BIGSERIAL PRIMARY KEY,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
