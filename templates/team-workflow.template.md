# Protocolo de Trabajo y Ceremonias del Equipo (Ways of Working)

> Célula: `<NOMBRE_CELULA>`
> Ciclo de Iteración: `Sprints de 2 semanas`

---

## 1. Calendario de Ceremonias
| Ceremonia | Día y Hora | Participantes | Entrada Principal | Salida Esperada |
|---|---|---|---|---|
| Sprint Planning | Lunes inicio sprint | Equipo completo | Backlog priorizado | Sprint Goal y tareas comprometidas |
| Daily Sync | Lunes a Viernes 09:30 | Equipo técnico | Tablero de sprint | Bloqueos detectados |
| Refinamiento Técnico | Miércoles intermedio | Líder + Devs + PO | HUs candidatas | Criterios desambiguados y DoR |
| Sprint Review | Viernes cierre sprint | Equipo + Stakeholders | Incremento de software | Demo funcional y feedback |
| Retrospectiva | Viernes post Review | Equipo completo | Experiencia del sprint | Acciones de mejora continua |

## 2. Estrategia de Ramas y Pull Requests
- **Ramas Protegidas:** `main` (producción) y `develop` (integración). Prohibido commits o push directos.
- **Ramas de Trabajo:** `feat/<TICKET>-<slug>`, `fix/<TICKET>-<slug>`, `hotfix/<TICKET>-<slug>`.
- **Regla de Pull Request:**
  - Requiere al menos 1 o 2 aprobaciones humanas.
  - Veredicto favorable de `/review-4r`.
  - Pipeline de CI en verde (compilación, pruebas unitarias y cobertura).

## 3. Matriz de Gates Humanos
- **G1 (Definition of Ready):** PO aprueba criterios de aceptación; Líder Técnico confirma contratos y dependencias.
- **G2 (Diseño y Contratos):** Arquitectura y paridad multi-canal confirmada antes de codificar UI.
- **G3 (Aprobación de PR):** Revisión de código y calidad técnica en el repositorio central.
- **G4 (Pase a Producción):** Despliegue formal verificado por DevOps / Líder Técnico.
