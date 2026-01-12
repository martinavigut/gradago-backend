# ADR-001: Modular Monolith First

## Status
Accepted

## Context
GradaGo is an early-stage backend system built by a small team with a strong focus on
correctness, transactional consistency, and interview-level signal (SDE II).

The system includes domains such as identity, catalog, booking, and notifications,
with strong data consistency requirements, especially around booking and inventory.

## Decision
We chose a **modular monolith architecture** as the initial system design.

The codebase is organized by bounded contexts (identity, catalog, booking, etc.),
with strict package boundaries and architectural rules, but deployed as a single application.

Microservices will only be introduced where there is a clear benefit.

## Rationale
This decision was driven by:

- Strong transactional consistency requirements (especially for booking)
- Faster iteration speed for a small team
- Easier debugging, testing, and local development
- Lower operational overhead compared to early microservices
- Ability to enforce architecture via tooling (e.g. ArchUnit)

## Consequences
- The system can evolve quickly without distributed system complexity
- Clear module boundaries make future extraction to microservices feasible
- Scaling is initially vertical rather than horizontal
- Cross-module calls remain in-process until justified otherwise

## Future Considerations
- Notification service is a candidate for early extraction
- Search/recommendation may be extracted if scaling or ownership requires it
- Service extraction must be justified via ADR
