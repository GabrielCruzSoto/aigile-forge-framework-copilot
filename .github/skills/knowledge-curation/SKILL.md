---
name: knowledge-curation
description: Protocolo de Knowledge Curation para auditar drift entre código y documentación, podar conocimiento obsoleto y promover ADRs.
---

# Skill: Knowledge Curation

## Propósito
Guiar al agente `@aff-curator` en la auditoría sistemática del ecosistema del proyecto, previniendo que la documentación se desactualice (*drift*) y asegurando que Copilot siempre lea contexto fidedigno y limpio.

## Metodología Paso a Paso

### 1. Auditoría de Drift de Arquitectura (`/drift-check`)
1. **Inspección de Endpoints y Contratos:**
   - Comparar los controladores REST reales en `@workspace` contra `knowledge/architecture/system-map.md` y `contract.md`.
   - Si existen nuevos endpoints no registrados o parámetros modificados, marcarlos como discrepancia.
2. **Inspección de Persistencia y Caching:**
   - Verificar si existen nuevas colecciones/tablas o cambios de esquema en código que no estén en la documentación.
3. **Generación del Reporte:**
   - Escribir `knowledge/drift-report.md` clasificando hallazgos como `CRITICAL` (contrato roto), `WARNING` (documentación faltante) o `INFO`.

### 2. Promoción de Decisiones Arquitectónicas (ADRs)
- Cuando una User Story o refactor introduzca una decisión de diseño de alto impacto (ej. cambio de motor de colas, nuevo patrón de persistencia o modificación de política de seguridad):
  1. Extraer la justificación de la decisión desde `work/.../design.md`.
  2. Redactar el Architecture Decision Record formal en `knowledge/architecture/adr/ADR-NNNN-<slug>.md`.
  3. Actualizar el índice de ADRs.

### 3. Poda y Limpieza de Conocimiento Obsoleto
- Detectar archivos de trabajo temporales (`work/`) de tickets cerrados y archivarlos en `archive/<YYYY>/`.
- Eliminar o marcar como `DEPRECATED` contratos viejos para evitar que Copilot sugiera implementaciones obsoletas.
- Sincronizar `.github/instructions/cell-context.instructions.md` con la versión más reciente del sistema.
