# Documentación de Aigile Forge Framework — Copilot Edition (AFF-Copilot)

Bienvenido a la documentación oficial de **Aigile Forge Framework — Copilot Declarative Edition (AFF-Copilot)**.

AFF-Copilot es un framework declarativo de ingeniería de software asistida por inteligencia artificial diseñado para **células ágiles empresariales** que operan sobre arquitecturas multi-repositorio (Backend Microservicios, Frontend Web y Aplicaciones Móviles Nativas iOS/Android).

---

## 🗺️ Mapa de la Documentación

Esta documentación está organizada en cuatro módulos temáticos para facilitar su consulta según el rol:

```
docs/es/
├── index.md                              # Este documento (portal de bienvenida)
├── architecture/
│   └── overview.md                       # Arquitectura técnica, Multi-Root y harness declarativo
├── guides/
│   ├── onboarding-setup.md               # Guía paso a paso para inicializar una célula desde cero
│   └── lifecycle-and-gates.md            # Ciclo de vida de 8 fases y los 4 Human Gates (G1 - G4)
├── agents/
│   └── catalog.md                        # Manual exhaustivo de los 11 agentes declarativos de Copilot
├── skills/
│   └── catalog.md                        # Catálogo de las 13 Agent Skills procedimentales
└── governance/
    └── security-and-sync.md              # Guardrails de seguridad empresarial y sincronización OneDrive
```

---

## 🚀 Principios Fundamentales del Framework

1. **100% Declarativo y Nativo:** Opera directamente en Visual Studio Code aprovechando GitHub Copilot Business (`.github/agents/`, `.github/prompts/`, `.github/instructions/`, `.github/skills/`). No requiere servidores MCP, servicios demonio en background ni compilación de binarios.
2. **Agnóstico y Dinámico:** No contiene datos hardcodeados de ninguna empresa, cliente o equipo. La identidad de la célula se construye dinámicamente mediante el agente `@aff-onboarding` y el comando `/init-cell`.
3. **Cero Huella Remota:** El framework reside en su propio repositorio orquestador y se conecta a los repositorios de código mediante un espacio de trabajo Multi-Root (`cell.code-workspace`). Las configuraciones locales se aíslan mediante `.git/info/exclude`.
4. **Paridad Multi-Canal (1:1):** Exige coherencia absoluta de contratos de datos, validaciones y códigos de error entre Web (Angular/React) y Móvil (Android Kotlin / iOS Swift).
5. **Calidad Determinista 4R:** Cada incremento de código es auditado bajo cuatro dimensiones (*Risk, Requirements, Regression, Resilience*) con una fase de refutación adversarial antes de habilitar el Pull Request.

---

## 📚 Ruta Recomendada de Lectura

- **Para Desarrolladores y QA:**
  1. [Guía de Puesta en Marcha e Instalación](guides/onboarding-setup.md)
  2. [Ciclo de Vida de 8 Fases y Gates](guides/lifecycle-and-gates.md)
  3. [Catálogo de Agent Skills](skills/catalog.md)

- **Para Líderes Técnicos y Arquitectos:**
  1. [Arquitectura del Framework y Multi-Root](architecture/overview.md)
  2. [Catálogo de Agentes Declarativos](agents/catalog.md)
  3. [Seguridad Empresarial y Sincronización OneDrive](governance/security-and-sync.md)

- **Para Product Owners y Scrum Masters:**
  1. [Onboarding de la Célula y Elicitación Bilingüe](guides/onboarding-setup.md)
  2. [Puertas de Calidad (Gates G1 a G4)](guides/lifecycle-and-gates.md)

---

> 🌐 **English Version:** You can access the complete documentation in English under [`docs/en/index.md`](../en/index.md) or start from [`README.en.md`](../../README.en.md).
