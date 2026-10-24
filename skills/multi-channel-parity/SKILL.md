---
name: multi-channel-parity
description: Protocolo de auditoría y sincronización 1:1 entre Web y Mobile Nativas (Android e iOS).
---

# Skill: Multi-Channel Parity

## Propósito
Guiar a los agentes `@aff-architect` y `@aff-qa` en la auditoría exhaustiva de coherencia entre el portal Web y las aplicaciones nativas Android (Kotlin) e iOS (Swift), evitando discrepancias de comportamiento entre plataformas.

## Las 4 Reglas de Oro de la Paridad

### 1. Cero Lógica de Negocio Pesada en Clientes
- Los cálculos financieros, tarifarios o de reglas de elegibilidad se evalúan **exclusivamente en el backend**.
- Web y Mobile solo renderizan los valores retornados por la API y envían selecciones del usuario.

### 2. Nombres de Propiedades Homogéneas
- Los payloads enviados y recibidos deben usar la misma convención (camelCase) y exactamente los mismos nombres de atributos en TypeScript, Kotlin y Swift.

### 3. Validaciones de Formulario Espejo
- Expresiones regulares de validación (email, teléfono, RUT o identificador fiscal) deben ser idénticas.
- Si un campo es obligatorio en Web, debe ser obligatorio en Android y en iOS con el mismo mensaje de error.

### 4. Mapeo Uniforme de Códigos de Error
- Un error de backend con código `ERR_INSUFFICIENT_FUNDS` debe mostrar un mensaje y flujo de recuperación idéntico en las tres plataformas.

## Procedimiento de Auditoría (`/parity-check`)
1. Leer los DTOs y clientes HTTP en los repositorios de Web, Android e iOS en `@workspace`.
2. Comparar campo por campo contra `contract.md`.
3. Elaborar la Matriz de Paridad en `contract.md#parity`:
   ```markdown
   | Campo / Acción | Web | Android | iOS | ¿Paridad 1:1? | Estado |
   |---|---|---|---|---|---|
   | amount (BigDecimal/Double) | amount | amount | amount | Sí | Conforme |
   | targetAccount (String) | targetAccount | targetAccount | destinationAccount | No (Corregir iOS) | Hallazgo |
   ```
4. Si se detectan discrepancias, bloquear el paso a desarrollo o exigir corrección inmediata.
