# ContiGO

**Primero conecta. Luego construye.**

ContiGO es una plataforma para que estudiantes encuentren personas que conecten con sus ideas, intereses y motivaciones — y quieran construirlas juntas.

> Lo demás se aprende.

---

## El problema

No es:

> “Los estudiantes no encuentran personas con determinadas habilidades.”

Es más profundo:

Un estudiante puede tener una idea que le apasiona, pero **no existe un mecanismo sencillo** que le permita encontrar a otras personas que:

- conecten con esa idea,
- compartan su motivación,
- y quieran construirla juntos.

### Ejemplo

Proyecto: *“Quiero desarrollar una herramienta para enseñar Braille mediante juegos.”*

Una persona podría no saber nada de Braille y aun así pensar:

> “Esta idea me encanta. Quiero aprender y ayudar a construirla.”

Esa persona puede ser **mucho más valiosa** para el proyecto que alguien con la habilidad exacta pero sin interés real en la idea.

Las habilidades se pueden aprender y desarrollar durante el proyecto.  
Lo fundamental es encontrar personas dispuestas a **comprometerse con la idea**.

---

## Filosofía

| Principio | Significado |
|-----------|-------------|
| Primero conecta | La afinidad con la idea y la motivación van antes que el CV de skills |
| Luego construye | El equipo nace del interés mutuo, no de un checklist técnico |
| Lo demás se aprende | No buscamos personas perfectas; buscamos personas que quieran construir juntas |

En la experiencia de la app esto aparece como guía, no solo como slogan:

- *¿No tienes todas las habilidades? No importa. Si conectas con la idea, puedes aprender lo demás.*
- *No buscamos personas perfectas. Buscamos personas que quieran construir juntas.*

---

## ¿Qué significa “hacer match”?

**Definición ContiGO:**

> Existe un match cuando dos estudiantes manifiestan interés mutuo en colaborar en una misma idea y consideran que existe suficiente afinidad personal, motivacional o de intereses para conocerse y evaluar una colaboración.

Un match **no** significa todavía “vamos a trabajar juntos”.  
Significa: **“Quiero conocerte porque creo que podemos construir algo juntos.”**

Después viene la conversación, la reunión y — si hay compromiso — el equipo.

| Match tradicional | Match ContiGO |
|-------------------|---------------|
| Tenemos skills compatibles | Los dos queremos construir **esto** |
| Filtro por carrera / requisitos | Afinidad con la idea + motivación |
| “Te necesito porque sabes X” | “Conecto contigo y con la idea” |

---

## Qué prioriza la aplicación

En vez de:

```
PROYECTO → Habilidades → Carrera → Descripción → Creador
```

ContiGO prioriza:

```
PERSONA
  → SU MOTIVACIÓN
  → SU IDEA
  → POR QUÉ QUIERE HACERLA
  → A QUIÉN ESTÁ BUSCANDO
  → HABILIDADES (complementarias)
```

Primero quieres que alguien diga: *“Me interesa esta persona y esta idea.”*  
Después: *“¿Qué puedo aportar?”*

### ¿Qué te mueve?

La carta de presentación no es un listado de skills. Es texto libre sobre motivación, cómo te emocionas con las ideas y qué buscas en otras personas.

### En cada idea

- **Conecto con la idea**
- **Quiero conocer más**
- Pregunta opcional: *¿Qué fue lo que te conectó?*  
  (problema, tema, idea relacionada, aprender, aportar, motivación, conocer al equipo)

### Match bidireccional

El creador también declara:

- **¿A quién estoy buscando?** — curiosidad, compromiso, ganas de aprender…
- **¿Qué puedo enseñar?**
- **¿Qué quiero aprender?**

---

## Flujo

```
        IDEA
          │
          ▼
   QUIÉN LA PROPONE
          │
          ▼
      ¿TE MUEVE?
      ┌────┴────┐
      NO        SÍ
                │
                ▼
              MATCH
                │
                ▼
          CONVERSACIÓN
                │
                ▼
             REUNIÓN
                │
                ▼
              EQUIPO
                │
                ▼
             AVANZAR
```

Las **habilidades** quedan como información complementaria, no como criterio principal.

Más adelante ContiGO puede incorporar **compatibilidad de equipo**: no solo formar el match, sino sostener si las personas realmente quieren avanzar juntas.

---

## Señales del match (concepto)

Antes del algoritmo en código, ContiGO responde:

*¿Qué hace que Eduardo conecte con la idea de Ana?*

Señales candidatas:

- Tema de la idea
- Motivación compartida
- Intereses en común
- Forma de trabajar
- Disponibilidad
- Disposición declarada (curiosidad, aprender, emprender)
- Razones explícitas de conexión

Las skills entran como contexto secundario (enseñar / aprender), no como filtro duro.

---

## Identidad visual

Violeta = conexión · Blanco = descubrimiento · Negro = contenido

| Color | Hex | Uso |
|-------|-----|-----|
| Violeta ContiGO | `#6C2BD9` | Botones, acciones |
| Violeta profundo | `#4B1FA6` | Activos, match, títulos |
| Violeta suave | `#F1EBFF` | Tarjetas, etiquetas |
| Blanco | `#FFFFFF` | Fondo principal |
| Negro | `#171717` | Texto |
| Gris oscuro | `#555555` | Texto secundario |
| Gris claro | `#E8E8E8` | Bordes |
| Fondo suave | `#F8F7FA` | Fondos alternativos |

Distribución aproximada: **70%** claros · **20%** violeta · **10%** negro.  
El violeta se intensifica en: *Me interesa → Match → Conexión → Reunión*.

---

## MVP (15 vistas)

Splash · Onboarding · Login · Registro · Crear perfil · Inicio · Explorar · Detalle proyecto · Crear proyecto · Solicitud de interés · Match · Conexiones · Conversación · Proponer reunión · Mi perfil

Navegación: **Inicio · Explorar · ＋ Crear · Conexiones · Perfil**

---

## Ángulo de investigación

Más interesante que “una app de matching por skills”:

> Sistema de apoyo para la formación de equipos multidisciplinarios basado en la afinidad entre estudiantes, sus motivaciones y las ideas de proyectos.

¿Existe relación entre **motivación + afinidad con la idea + disposición a aprender** y la **formación / continuidad** de equipos?

---

## Estado del repositorio

| Capa | Estado |
|------|--------|
| Filosofía / producto | Definida |
| App Flutter | Simulación Android con datos mock |
| Backend Supabase | Pendiente |
| Auth Google / FCM | Pendiente |

**Stack previsto:** Flutter (Android) · Supabase · Google Auth · Firebase Cloud Messaging

---

## En una frase

ContiGO no busca personas perfectas.  
Busca personas que quieran construir juntas.

**Lo demás se aprende.**
