# spec.md — <HU-KEY> <Título>

> Versión: `v0.1` | Estado Global: `BORRADOR`
> Célula: "The Last of Code" (Seguros Digitales · Scotiabank)

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
  - **Given** el cliente se encuentra autenticado en el portal web o app móvil
  - **When** solicita la cotización de un seguro
  - **Then** el sistema retorna el monto de la prima calculado por el microservicio backend

---

## 4. Matriz de Paridad Multi-Canal
| Campo / Regla | Web Angular | Android (Kotlin) | iOS (Swift) | ¿Paridad 1:1? |
|---|---|---|---|---|
| Cálculo de Prima | Solo muestra | Solo muestra | Solo muestra | Sí (Backend) |
| Código de Error | `ERR_INS_001` | `ERR_INS_001` | `ERR_INS_001` | Sí |
