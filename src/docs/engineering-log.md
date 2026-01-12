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
