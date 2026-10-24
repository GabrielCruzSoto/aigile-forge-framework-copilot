---
description: Guía paso a paso para configurar el contexto completo de una célula (equipo, empresa, negocio, stack y workflow).
---

# Inicialización y Onboarding de Célula (`/init-cell`)

Actúa como el agente `aff-onboarding` para levantar el contexto de esta célula de trabajo.
Realiza una entrevista guiada o procesa los datos suministrados por el usuario en las siguientes 6 dimensiones:

## Paso 1: Identidad del Equipo
- Nombre oficial de la célula / equipo.
- Slug identificador (usado en prefijos de ramas y cache, ej. `pagos-core`).
- Canal de comunicación y repositorio principal.

## Paso 2: Personal y Roles
- ¿Quién es el Líder Técnico / Arquitecto?
- ¿Quién es el Product Owner (PO) / Scrum Master?
- Integrantes por capa: Backend Devs, Frontend Devs, Mobile Devs, QA Engineer.

## Paso 3: Empresa y Entorno
- Nombre de la empresa cliente / contratante.
- Políticas de seguridad relevantes (cero PII, secretos, regulaciones locales).
- Gestor de tareas (Jira, Monday, Azure DevOps) y hosting de código (Bitbucket, GitHub, GitLab).

## Paso 4: Dominio de Negocio
- ¿Cuál es el producto o servicio que desarrolla la célula?
- Glosario de 5 a 10 términos clave de negocio (con definición corta).
- Principales usuarios / clientes que consumen la solución.

## Paso 5: Arquitectura, Stack e Infraestructura
- Lista de microservicios / aplicaciones y su stack (Java, Kotlin, Angular, Android, iOS, Node, etc.).
- Motores de base de datos y cache (Postgres, MySQL, MongoDB, Redis, etc.).
- Herramienta de CI/CD (Jenkins, GitLab CI, GitHub Actions) y nube/on-prem.

## Paso 6: Forma de Trabajo del Equipo
- Duración del Sprint y días de ceremonias (Planning, Refinamiento, Review, Retro).
- Estrategia de ramas (GitFlow: `develop`/`release`/`main`, Trunk-Based).
- Reglas de Gates (G1: DoR / G2: Contrato / G3: PR aprobado / G4: Despliegue).

## Salida Esperada:
Tras responder las preguntas (o proveer un documento inicial), genera o actualiza:
1. `cell.config.yaml`
2. `knowledge/team/roster.md`
3. `knowledge/business/overview.md` y `knowledge/business/glossary.md`
4. `knowledge/architecture/system-map.md`
5. `knowledge/team/workflow.md`
6. `.github/instructions/cell-context.instructions.md`
