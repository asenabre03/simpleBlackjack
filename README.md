# Blackjack en Bash

Este es un sencillo juego de **Blackjack** programado en **Bash** que puedes ejecutar en tu terminal. ¡Compite contra el dealer y trata de alcanzar 21 sin pasarte!

---

## 🎮 Cómo jugar al Blackjack

El Blackjack es un juego de cartas en el que el objetivo es obtener una mano con un valor lo más cercano posible a **21**, sin pasarse. Las reglas básicas son:

- Cada carta numérica (del 2 al 10) vale su número.
- Las figuras (J, Q, K) valen **10** puntos.
- El As (A) vale **11** puntos, pero si la mano supera 21, su valor cambia a **1**.
- Cada jugador comienza con **dos cartas**.
- Puedes decidir **pedir** cartas adicionales o **plantarte**.
- El dealer debe pedir cartas hasta que su mano sume al menos **17 puntos**.
- Gana quien tenga la mano con mayor valor sin superar **21**.

---

## 🚀 Cómo jugar en la terminal

### 📌 Requisitos

- Sistema operativo basado en Unix (Linux/macOS).
- Tener Bash instalado.

### 📥 Instalación y ejecución

1. Clona el repositorio con `git clone` o descárgalo a través de `wget`.
   ```sh
   git clone https://github.com/asenabre03/simpleBlackjack.git
   wget https://github.com/asenabre03/simpleBlackjack/archive/refs/heads/main.zip
   ```
2. Otorga permisos de ejecución al script.
   ```sh
   chmod +x simpleBlackjack.sh
   ```
3. Ejecuta el juego con `./`.
   ```sh
   ./blackjack.sh
   ```

---

## 🃏 Funcionamiento del script

El script **blackjack.sh** sigue estos pasos:

1. Se inicializan las cartas y los palos.
2. Se reparten **dos cartas** al jugador y al dealer.
3. El jugador decide si **pide carta** o **se planta**.
4. Si el jugador no se ha pasado de 21, el dealer juega su turno.
5. Se comparan las manos y se declara un ganador.
6. Se ofrece la opción de volver a jugar.

---
