-- V2__identity_users_roles.sql
-- Objetivo:
-- 1) Definir el schema base de Identity para el proyecto:
--    - users: cuentas del sistema
--    - roles: roles disponibles (USER/ORGANIZER/ADMIN)
--    - user_roles: relación N:M (un usuario puede tener varios roles)
--
-- 2) Dejar seeds mínimos de roles para que el backend no dependa
--    de inserts manuales al correr en local/CI.

-- 1) Tabla principal de usuarios
CREATE TABLE users (
  -- Usamos UUID como PK para evitar IDs predecibles y facilitar merges/sharding en el futuro.
  id UUID PRIMARY KEY,

  -- Email como identidad de login. Unique para evitar duplicados.
  email VARCHAR(254) NOT NULL UNIQUE,

  -- Guardamos el hash, NUNCA el password en texto plano.
  -- 100 chars alcanza para BCrypt.
  password_hash VARCHAR(100) NOT NULL,

  -- Timestamp de creación para auditoría básica.
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- 2) Catálogo de roles disponibles
CREATE TABLE roles (
  -- SMALLSERIAL: pocos roles, es eficiente y simple.
  id SMALLSERIAL PRIMARY KEY,

  -- Nombre del rol (USER/ORGANIZER/ADMIN). Unique para no repetir.
  name VARCHAR(50) NOT NULL UNIQUE
);

-- 3) Join table: usuarios ↔ roles (muchos a muchos)
CREATE TABLE user_roles (
  -- FK al usuario. Si se borra el usuario, borramos sus roles asignados.
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,

  -- FK al rol. Si se borra el rol (raro), también se limpian asignaciones.
  role_id SMALLINT NOT NULL REFERENCES roles(id) ON DELETE CASCADE,

  -- PK compuesta para evitar duplicados (mismo rol asignado dos veces al mismo usuario).
  PRIMARY KEY (user_id, role_id)
);

-- 4) Seeds mínimos: roles base del sistema.
-- ON CONFLICT evita error si el migration se re-ejecuta en una DB ya inicializada.
INSERT INTO roles (name) VALUES ('USER'), ('ORGANIZER'), ('ADMIN')
ON CONFLICT (name) DO NOTHING;
