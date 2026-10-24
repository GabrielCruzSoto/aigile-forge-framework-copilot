---
name: checkpoint-resume
description: Protocolo de congelamiento en menos de 30 segundos y retoma limpia de tareas activas ante urgencias o cambios de contexto.
---

# Skill: Checkpoint and Resume Protocol

## Propósito
Guiar al agente `@aff-orchestrator` en el congelamiento ultrarrápido (`< 30s`) del estado de una tarea activa y su posterior retoma limpia sin perder contexto ni recurrir a `git stash`.

## Metodología Paso a Paso

### 1. Protocolo de Congelamiento (`aff-checkpoint`)
Al ingresar una interrupción o urgencia de alta prioridad:
1. **Commit Temporal WIP:**
   - En el repositorio de trabajo local de la tarea activa, realizar un commit temporal en la rama de feature:
     ```bash
     git add -A
     git commit -m "wip(<TICKET>): checkpoint before priority switch"
     ```
2. **Actualización de `state.yaml`:**
   - Cambiar `status: paused`.
   - Registrar `checkpoint.last_paused_at` con timestamp actual.
   - Declarar en `checkpoint.next_step` la acción técnica exacta que estaba a punto de ejecutarse (ej. `"implementar test rojo para CA-02 en OrderServiceTest"`).
3. **Resumen de Handoff:**
   - Generar un bloque de 3 líneas resumiendo el estado para notificación en el gestor de tareas.

### 2. Atención de la Urgencia
- La urgencia se trabaja en su propia rama `hotfix/<ID>-<slug>` o espacio de trabajo aislado, sin tocar el estado de la tarea pausada.

### 3. Protocolo de Retoma Limpia (`aff-resume-task`)
Superada la urgencia:
1. **Recuperación de Estado:**
   - Leer `state.yaml#checkpoint` para reconstruir en memoria el punto exacto de interrupción.
2. **Verificación de Rama Base:**
   - Ejecutar `git fetch` en la rama base (`develop` o `main`) para detectar si el hotfix o cambios concurrentes modificaron archivos compartidos.
   - Si hubo cambios en la base, proponer o ejecutar un `git rebase` limpio.
3. **Restauración:**
   - Cambiar `status: active` en `state.yaml`.
   - Presentar al desarrollador en consola un resumen ejecutivo de máximo 10 líneas con el próximo comando a ejecutar.
