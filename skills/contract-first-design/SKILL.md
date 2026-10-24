---
name: contract-first-design
description: Protocolo para diseñar contratos REST, esquemas de persistencia, mocks sintéticos y compatibilidad N/N-1.
---

# Skill: Contract-First Design

## Propósito
Guiar al agente `@aff-architect` en la definición previa de contratos REST/JSON (`contract.md`) y el diseño de integración cross-servicio (`design.md`) para desacoplar el desarrollo de Backend, Web y Mobile.

## Flujo de Ejecución Paso a Paso

### 1. Definición de Endpoints y Payloads
- Especificar método HTTP, ruta con versionado (`/api/v1/...`) y descripción funcional.
- Declarar headers requeridos de trazabilidad (`X-Correlation-Id`, `X-Trace-Id`).
- Definir schemas de Request y Response en JSON tipado estricto.
- Mapear códigos de error HTTP (400, 401, 403, 404, 409, 500) a estructuras homogéneas `ProblemDetail` (RFC 7807):
  ```json
  {
    "type": "https://api.example.com/errors/invalid-account",
    "title": "Invalid Account Status",
    "status": 409,
    "detail": "The destination account is blocked.",
    "code": "ERR_ACC_BLOCKED",
    "correlationId": "req-987123"
  }
  ```

### 2. Generación de Mocks Sintéticos
- Crear ejemplos JSON completos y realistas para respuestas exitosas y errores habituales.
- Estos mocks se colocan en `contract.md#mocks` y son consumidos por Frontend Web y Mobile desde el primer día, permitiendo programar UI sin esperar al Backend.

### 3. Persistencia y Caching
- **Document DBs / Tablas:** Declarar nombres de colecciones/tablas y los índices requeridos (índices simples o `@CompoundIndex`).
- **Cache en Memoria:** Declarar la convención de clave `{cell}:{service}:{entity}:{id}` y el tiempo de vida explícito (`TTL` en segundos).

### 4. Compatibilidad N/N-1 y Despliegue en `design.md`
- Detallar cómo conviven versiones nuevas y viejas de clientes con el backend durante un release.
- Orden de despliegue estricto: Migraciones de BD -> Backend APIs -> Frontend Web -> Publicación Mobile.
- Plan de rollback operativo.
