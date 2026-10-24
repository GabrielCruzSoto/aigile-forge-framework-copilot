---
name: enterprise-security-audit
description: Procedimiento de auditoría de seguridad corporativa contra fugas de PII, secretos, consultas no indexadas y configuraciones inseguras.
---

# Skill: Enterprise Security Audit

## Propósito
Guiar al agente `@aff-security` en la inspección estricta de cambios de código y artefactos técnicos para prevenir incidentes de seguridad, fugas de datos confidenciales o fallos de cumplimiento regulatorio.

## Metodología Paso a Paso

### 1. Clasificación de Datos y Detección de PII
- Inspeccionar diffs, schemas y logs buscando:
  - Nombres reales de clientes o identificadores fiscales/nacionales.
  - Números de tarjetas de crédito o débito (PAN) mediante el algoritmo de Luhn o patrones de 16 dígitos.
  - Contraseñas en texto claro, tokens JWT hardcodeados o llaves privadas SSH/TLS.
- **Acción Obligatoria:** Reemplazar cualquier dato real encontrado por placeholders sintéticos (`<REDACTED:tipo>`).

### 2. Auditoría de Persistencia y Caching
- **Bases de Datos de Documentos / Relacionales:**
  - Inspeccionar métodos de repositorio y queries buscando filtros o joins sobre columnas o campos sin índice declarado.
  - Exigir la anotación de `@CompoundIndex` o creación de índices en migraciones para campos transaccionales.
- **Capa de Cache:**
  - Verificar que toda escritura en cache incluya un `TTL` explícito y seguro.
  - Comprobar que no se almacenen objetos con datos personales sensibles sin cifrado.

### 3. Almacenamiento Seguro en Clientes Móviles
- **Android:** Verificar que los tokens de sesión se almacenen en `EncryptedSharedPreferences` respaldado por `Android KeyStore`.
- **iOS:** Verificar que los tokens y credenciales se almacenen en `Keychain Services`. Bloquear estrictamente cualquier uso de `UserDefaults` para datos sensibles.

### 4. Generación de `security-review.md`
- Clasificar cada hallazgo según el estándar CVSS / OWASP: `CRITICAL`, `HIGH`, `MEDIUM`, `LOW`.
- Emitir veredicto vinculante para Gate G2 (co-firma con arquitectura) y Gate G3 (bloqueante si existen hallazgos `CRITICAL` o `HIGH` no resueltos).
