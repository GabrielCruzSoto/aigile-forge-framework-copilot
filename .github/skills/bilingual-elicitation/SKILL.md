---
name: bilingual-elicitation
description: Procedimiento para desambiguar requerimientos vacíos generando hipótesis y máximo 10 preguntas P1 bilingües con opción recomendada.
---

# Skill: Bilingual Elicitation

## Propósito
Guiar al agente `@aff-pm` en la transformación de historias de usuario o tareas de Jira que nacen "solo con título" en un documento formal de elicitación (`elicitation.md`), evitando reuniones improvisadas o bloqueos en desarrollo.

## Flujo de Ejecución Paso a Paso

### 1. Extracción de Intención
A partir únicamente del título de la HU y los títulos de sus tareas hijas:
- Consultar `knowledge/business/glossary.md` y `knowledge/architecture/system-map.md`.
- Formular entre 2 y 4 **Hipótesis Iniciales**:
  - *Hipótesis de Negocio:* Qué beneficio espera el usuario final.
  - *Hipótesis de Canales:* Qué experiencia se espera en Web y Mobile.
  - *Hipótesis Técnica:* Qué servicios backend y modelos de datos intervienen.

### 2. Formulación de Preguntas P1 Bloqueantes (Máximo 10)
Identificar vacíos críticos que impiden codificar o estimar:
- Redactar cada pregunta de forma **Bilingüe (Español e Inglés)**:
  - Formato: `Q{N} (ES): ...` y `Q{N} (EN): ...`
- Ofrecer un abanico cerrado de opciones (`A`, `B`, `C`).
- **Mandatorio:** Incluir siempre una **Propuesta por Defecto (Recommended)** justificada técnicamente según la arquitectura existente:
  ```markdown
  ### Q1 (ES): ¿La anulación de una transacción debe procesarse sincrónica o asincrónicamente?
  - **Q1 (EN):** Should transaction cancellation be processed synchronously or asynchronously?
  - **Opciones:**
    - `A`: Sincrónica con bloqueo de estado inmediato.
    - `B`: Asincrónica mediante cola de eventos con compensación.
  - **Propuesta por Defecto (Recommended):** `A` — El contrato actual de pagos opera en tiempo real bajo SLA de 3 segundos.
  ```

### 3. Preguntas Técnicas por Capa
Desglosar preguntas secundarias para los desarrolladores de cada capa:
- **Backend:** Persistencia, idempotencia, timeouts.
- **Web:** Flujo de navegación, validaciones de formulario.
- **Mobile:** Comportamiento offline, permisos, almacenamiento seguro.

### 4. Salida Verificable
Escribir el resultado en `work/<HU-KEY>-<slug>/elicitation.md` utilizando `templates/elicitation.template.md`.
