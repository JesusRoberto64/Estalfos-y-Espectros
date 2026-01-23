# 🎮 Godot – Proyecto Educativo con Actividades Guiadas

Este repositorio contiene un **proyecto educativo en Godot Engine**, diseñado como una serie de **actividades prácticas organizadas por carpetas**, donde cada una desarrolla una mecánica específica de un videojuego 2D.

El objetivo es que estudiantes o personas autodidactas aprendan **Godot paso a paso**, desde lo más básico hasta sistemas más avanzados como enemigos, portales, UI y balance de dificultad.

Cada carpeta representa una **actividad independiente**, con recursos, escenas y scripts necesarios para completar el ejercicio.

---

## 📦 Requisitos

* Descargar **Godot Engine (versión recomendada: Godot 4.x)**
* Tener conocimientos básicos de computación (no se requiere experiencia previa en programación)
* Recursos gráficos incluidos o descargables según el taller

---

## 🧠 Estructura General del Proyecto

El proyecto está organizado en carpetas para mantener el contenido ordenado:

* **ARTE** → Sprites, animaciones e imágenes
* **LÓGICA** → Scripts y código
* **ESCENAS** → Niveles, UI y escenas jugables

Cada **actividad** incluye su propio avance funcional del juego.

---

# 📁 Estructura del proyecto

### 🟢 Introducción

**Introducción y bienvenida al taller**

* Bienvenida general
* Demostración del ejercicio final
* Instalación de Godot Engine
* Descarga de recursos gráficos
* Preparación del entorno de trabajo

---

## 🔵 Conocer el motor Godot Engine

* Introducción a la interfaz de Godot
* Organización de carpetas:

  * `ARTE`
  * `LOGICA`
  * `ESCENAS`
* Importación de arte
* Explicación de nodos y escenas
* Creación de la primera escena
* Creación de nodos:

  * `CharacterBody2D`
  * `AnimatedSprite2D`
* Animación **idle**
* Prueba de escena

---

# 🧩 Actividades

## 🟡 Actividad 1: Movimiento

* Configuración de resolución de ventana
* Animación de caminar
* Introducción al código
* Movimiento izquierda/derecha
* Cámara
* Fondo con scroll infinito

## 🟡 Actividad 2: Salto

* Animación de salto
* Lógica de salto
* Ajuste de física
* Personalización del salto

## 🟡 Actividad 3: Terreno

* `TileMapLayer`
* Colisiones en tiles
* Construcción del nivel
* Colisiones del jugador
* Diseño libre del nivel

## 🟡 Actividad 4: Coleccionables

* `Area2D`
* Colisiones
* `AnimatedSprite2D`
* Desaparición al recolectar
* Sistema de rejilla
* Nodo padre de coleccionables

## 🟡 Actividad 5: Contadores (UI)

* `CanvasLayer`
* `Label`
* Icono de coleccionable
* Script Overlord
* Sistema de conteo
* Comunicación entre nodos

## 🟡 Actividad 6: Hazard (peligros)

* Áreas de daño
* Sprites
* Reinicio de escena
* Condición de perder
* Caída al abismo

## 🟡 Actividad 7: Meta (final del nivel)

* Área de meta
* Animaciones
* Estado de victoria
* UI de éxito
* Conexión con Overlord

## 🟡 Actividad 8: Portal / Niveles

* Duplicación de niveles
* Sistema de niveles
* Script singleton
* Variable `current_level`
* Sistema de cambio de nivel

## 🟡 Actividad 9: Pantalla de título

* Escena principal
* Botones de iniciar y salir
* Señales
* Menú principal

## 🟡 Actividad 10: Enemigos

* `CharacterBody2D`
* Animaciones
* Colisiones
* IA básica
* Diseño de nivel con enemigos

## 🟡 Actividad 11: Ataque

* Animaciones de ataque
* Áreas de golpe
* Sistema de combate

## 🟡 Actividad 12: Destrucción de enemigos

* Animación de daño
* Eliminación de enemigos
* Sistema de daño al jugador
* Hurt system

## 🟡 Actividad 13: Spawner de enemigos

* Nodo spawner
* Marcadores de posición
* Generación dinámica de enemigos

## 🟡 Actividad 14: Balanceo de dificultad

* Playtesting
* Feedback de jugadores
* Ajustes de dificultad
* Diseño de experiencia

## 🟡 Actividad 15: Pause

* Escena de pausa
* Script de pausa
* Integración en niveles

---

# 🎯 Objetivo del proyecto

Este repositorio no busca solo enseñar Godot, sino enseñar:

* 🧱 Arquitectura de proyectos
* 🧠 Pensamiento de diseño de juegos
* 🎮 Lógica de gameplay
* 🖼️ Integración arte + código
* 🔁 Sistemas reutilizables
* 🧩 Escalabilidad de proyectos

---

# 👥 Enfoque educativo

Pensado para:

* Talleres
* Clubes de desarrollo
* Autoaprendizaje
* Educación independiente
* Formación autodidacta
* Introducción a carreras creativas-tecnológicas

---

# 📜 Licencia MIT

Este proyecto es de uso educativo.
Puede ser usado como material de aprendizaje, referencia o base para proyectos personales.
