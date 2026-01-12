# GradaGo Engineering Log (Bitácora)

Este documento registra decisiones técnicas pequeñas y operativas del proyecto.
Para decisiones arquitectónicas grandes usamos ADRs en `docs/adr/`.

## 2026-01-12
### Bootstrap del proyecto (Semana 0)
- **Spring Boot generado con Initializr**
  - Motivo: acelerar setup base y estandarizar dependencias del equipo.
- **Postgres via Docker Compose**
  - Motivo: entorno local reproducible, sin installs manuales.
- **Flyway habilitado**
  - Motivo: schema versionado y reproducible; evita “works on my machine”.
  - Convención: `V{n}__description.sql` en `src/main/resources/db/migration`.
- **Actuator habilitado**
  - Motivo: health checks y base para observability (más adelante metrics/traces).
  - Nota: por ahora exponemos `health/info` (se ajustará con security).
- **application.yml (no properties)**
  - Motivo: configuración más legible/estructurada.

### Convenciones iniciales
- Commits: pequeños y con intención (`chore/feat/test/docs`).
- No se commitea `target/` (build output).

## 2026-01-12
### Identity – schema y dominio base (inicio Semana 1)
- **Refactor de package raíz (`com.gradago.api` → `com.gradago`)**
  - Motivo: permitir component-scan correcto para un monolito modular.
  - Impacto: evita problemas futuros al agregar módulos (`identity`, `catalog`, `booking`).

- **Flyway V2 – Identity schema**
  - Se agregó migración `V2__identity_users_roles.sql`.
  - Define tablas: `users`, `roles`, `user_roles`.
  - Incluye seed de roles (`USER`, `ORGANIZER`, `ADMIN`).
  - Decisión: mantener `V1__init.sql` como bootstrap técnico y evolucionar con V2+.

- **Validación de migraciones**
  - Se verificó estado de Flyway usando `flyway_schema_history`.
  - Nota: se reseteó DB local (`docker compose down -v`) tras modificar migraciones ya aplicadas.

- **Entidad y repositorio base de usuario**
  - Se agregó entidad JPA `User` alineada con el schema definido por Flyway.
  - Se agregó `UserRepository` usando Spring Data JPA.
  - Hibernate configurado solo en modo `validate`; Flyway es el owner del schema.

- **Estado actual**
  - La aplicación arranca correctamente.
  - Flyway V1 y V2 aplicados sin errores.
  - Persistencia base lista para implementar registro de usuarios.
