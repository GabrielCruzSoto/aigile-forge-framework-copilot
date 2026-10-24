# spec.md — <HU-KEY> <Título>

> Versión: `v0.1` | Estado Global: `BORRADOR`
> Célula: `<NOMBRE_CELULA>`

---

## 1. Registro de Cambios (Changelog de Spec)
| Versión | Fecha | Autor / Ceremonia | Resumen de Cambios |
|---|---|---|---|
| `v0.1` | `YYYY-MM-DD` | Planning inicial | Hipótesis preliminares post `/elicit-ticket` |

---

## 2. Alcance Funcional
- **Incluido:**
- **Excluido:**

---

## 3. Criterios de Aceptación y Madurez
> Estados de madurez: `HIPOTESIS` (sin confirmar), `CONFIRMADO` (validado por PO), `VALIDADO` (probado en demo).

### CA-01: [Título del Criterio]
- **Estado:** `[HIPOTESIS | CONFIRMADO | VALIDADO]`
- **Origen:** `Q1 (elicitation.md)`
- **Escenario Gherkin:**
  - **Given** el usuario se encuentra autenticado en el portal web o app móvil
  - **When** ejecuta la acción de negocio
  - **Then** el sistema procesa la solicitud mediante el backend y responde con el resultado esperado

---

## 4. Matriz de Paridad Multi-Canal
| Campo / Regla | Web | Android | iOS | ¿Paridad 1:1? |
|---|---|---|---|---|
| Regla de Validación | Backend | Backend | Backend | Sí (Backend) |
| Código de Error | `ERR_CODE_001` | `ERR_CODE_001` | `ERR_CODE_001` | Sí |
