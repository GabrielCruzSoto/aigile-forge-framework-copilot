---
name: cell-onboarding-bootstrap
description: Metodología paso a paso para guiar el onboarding y estructurar todo el contexto operativo de una célula ágil.
---

# Skill: Cell Onboarding Bootstrap

## Propósito
Guiar al agente `@aff-onboarding` en la realización de la entrevista estructurada y la generación de los artefactos base de contexto para cualquier célula de ingeniería que adopte el framework.

## Flujo de Ejecución Paso a Paso

### 1. Entrevista Estructurada
El agente debe solicitar o inferir la información de las 6 dimensiones fundamentales:
1. **Identidad del Equipo:**
   - Nombre de la célula (ej. *Core Payments*, *Customer Onboarding*).
   - Slug identificador para ramas, repos y cache (ej. `payments-core`).
   - Propósito general en 1 o 2 oraciones.
2. **Personal y Roster:**
   - Líder Técnico / Arquitecto responsable.
   - Product Owner y Scrum Master.
   - Lista de desarrolladores por capa (Backend, Frontend, Mobile, QA).
3. **Empresa y Gobernanza:**
   - Organización o empresa cliente.
   - Nivel de cumplimiento regulatorio y políticas de privacidad (cero PII).
   - Herramientas: VCS (Bitbucket/GitLab/GitHub), CI/CD (Jenkins/Actions) y gestor de tareas (Jira/Monday).
4. **Dominio de Negocio:**
   - Problema que resuelve el software.
   - Glosario de 5 a 10 términos de negocio con su significado técnico.
   - Usuarios clave de la aplicación.
5. **Arquitectura y Stack Técnico:**
   - Listado de microservicios y repositorios con su lenguaje y framework.
   - Bases de datos (relacional/NoSQL) y motor de cache.
   - Entornos de despliegue (`Local -> DEV -> QA -> PROD`).
6. **Forma de Trabajo (Ways of Working):**
   - Duración del Sprint y calendario de ceremonias.
   - Modelo de ramas (GitFlow: `develop`/`main` o Trunk-Based).
   - Criterios de paso de los Gates G1 a G4.

### 2. Generación de Artefactos
Con los datos confirmados, el agente debe generar:
1. `cell.config.yaml` tomando como base `templates/cell.config.template.yaml`.
2. `knowledge/team/roster.md` desde `templates/team-roster.template.md`.
3. `knowledge/business/overview.md` y `glossary.md` desde `templates/business-overview.template.md`.
4. `knowledge/architecture/system-map.md` desde `templates/architecture-system-map.template.md`.
5. `knowledge/team/workflow.md` desde `templates/team-workflow.template.md`.
6. `.github/instructions/cell-context.instructions.md` con un resumen compacto para inyección automática en Copilot.

### 3. Validación de Completitud
- Verificar que no queden marcadores `<PENDIENTE>` o placeholders sin completar.
- Confirmar que los repositorios declarados en `cell.config.yaml` coincidan con las carpetas en `cell.code-workspace`.
