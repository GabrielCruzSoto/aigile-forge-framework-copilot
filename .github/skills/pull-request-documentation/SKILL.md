---
name: pull-request-documentation
description: Procedimiento para redactar Pull Requests completos y trazables con notas de release, impacto técnico y plan de rollback.
---

# Skill: Pull Request Documentation and Release Preparation

## Propósito
Guiar a los agentes `@aff-implementer` y `@aff-reviewer` en la redacción del archivo `pr.md` previo a la apertura del Pull Request en el repositorio central (Gate `G3`), asegurando que los revisores humanos cuenten con toda la evidencia necesaria para aprobar sin fricción.

## Metodología Paso a Paso

### 1. Recopilación de Metadatos de la Tarea
- Clave y título de la User Story / Tarea (ej. `PAY-104`).
- Lista de commits atómicos incluidos en la rama (`git log --oneline base..HEAD`).
- Criterios de aceptación Given/When/Then que se satisfacen.

### 2. Estructuración del Documento `pr.md`
El documento debe construirse con las siguientes 6 secciones obligatorias:
1. **Resumen Funcional:** Explicación ejecutiva de 2 párrafos sobre qué problema resuelve el PR y para qué usuario.
2. **Criterios de Aceptación Cubiertos:** Tabla con ID de Criterio, descripción y test automatizado que lo valida.
3. **Impacto Técnico y de Arquitectura:**
   - ¿Afecta contratos públicos o schemas JSON? (Detallar compatibilidad `N/N-1`).
   - ¿Requiere migraciones de base de datos? (Scripts de migración o creación de índices).
   - ¿Modifica variables de entorno o configuración de CI/CD?
4. **Evidencia de Pruebas:**
   - Enlace o resumen de `evidence.md` con resultado de pruebas unitarias y de integración en verde.
   - Resultado de la revisión adversarial `/review-4r` adjunto.
5. **Notas de Release:** Fragmento para el changelog visible para usuarios y stakeholders.
6. **Plan de Rollback:** Pasos técnicos detallados para revertir el despliegue si se detectan anomalías en producción.

### 3. Salida Verificable
Escribir el bloque formateado en `repos/<repo>/pr.md`, listo para ser copiado en la descripción del PR de Bitbucket, GitHub o GitLab.
