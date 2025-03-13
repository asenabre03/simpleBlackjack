#!/bin/bash
clear

# Cambiar el título de la ventana del terminal
echo -ne "\033]0;Blackjack\007"

# Definir símbolos para los palos
declare -A palos
palos[0]="♦"  # Rombos
palos[1]="♥"  # Corazones
palos[2]="♠"  # Picas
palos[3]="♣"  # Tréboles

# Función para calcular el valor de una mano
calcularValorMano() {
    local mano=("$@")
    local valor=0
    local ases=0

    for carta in "${mano[@]}"; do
        valorCarta="${carta:0:-1}"  # Obtener el valor sin el palo
        case $valorCarta in
            A) valor=$((valor + 11)); ases=$((ases + 1));;      # As
            2|3|4|5|6|7|8|9) valor=$((valor + valorCarta));;    # 2-9
            10|J|Q|K) valor=$((valor + 10));;                   # 10, J, Q y K
        esac
    done

    # Ajustar el valor si hay ases y la mano es mayor de 21
    while (( valor > 21 && ases > 0 )); do
        valor=$((valor - 10))
        ases=$((ases - 1))
    done

    echo $valor
}

# Función para mostrar la mano
mostrarMano() {
    local mano=("$@")
    for carta in "${mano[@]}"; do
        echo -n "$carta "
    done
    echo
}

# Función para mostrar el resultado en color
mostrarResultado() {
    local mensaje="$1"
    local color="$2"
    echo -e "\e[1;${color}m$mensaje\e[0m"
}

# Función para mostrar separador
mostrarSeparador() {
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
}

# Función para repartir cartas
repartirCarta() {
    local cartasDisponibles=(2 3 4 5 6 7 8 9 10 J Q K A)
    local carta=${cartasDisponibles[$((RANDOM % 13))]}
    local palo=${palos[$((RANDOM % 4))]}  # Seleccionar un palo aleatorio
    echo "$carta$palo"
}

# Función principal del juego
jugarPartida() {
    # Inicializar manos
    manoJugador=()
    manoDealer=()

    # Repartir dos cartas a cada jugador
    for i in {1..2}; do
        manoJugador+=($(repartirCarta))
        manoDealer+=($(repartirCarta))
    done

    # Mostrar manos iniciales
    mostrarSeparador
    echo -e "\e[1mMano del jugador:\e[0m"
    mostrarMano "${manoJugador[@]}"
    echo -e "\e[1mMano del dealer:\e[0m"
    mostrarMano "${manoDealer[0]} ?"  # Muestra solo una carta del dealer
    mostrarSeparador

    # Turno del jugador
    while true; do
        valorJugador=$(calcularValorMano "${manoJugador[@]}")
        echo -e "\e[1mValor de la mano del jugador: $valorJugador\e[0m"

        if (( valorJugador == 21 )); then
            mostrarResultado "¡Blackjack! El jugador gana." "32"
            mostrarSeparador
            return
        elif (( valorJugador > 21 )); then
            mostrarResultado "El jugador se pasa de 21. ¡El dealer gana!" "31"
            mostrarSeparador
            return
        fi

        read -p "¿Quieres (1) pedir otra carta o (2) plantarte? " eleccion
        if [[ $eleccion -eq 1 ]]; then
            manoJugador+=($(repartirCarta))
            echo -e "\e[1mMano del jugador:\e[0m"
            mostrarMano "${manoJugador[@]}"
        else
            break
        fi
    done

    # Turno del dealer
    mostrarSeparador
    echo -e "\e[1mMano del dealer:\e[0m"
    mostrarMano "${manoDealer[@]}"
    while true; do
        valorDealer=$(calcularValorMano "${manoDealer[@]}")
        if (( valorDealer < 17 )); then
            manoDealer+=($(repartirCarta))
            echo "El dealer pide otra carta."
            echo -e "\e[1mNueva mano del dealer:\e[0m"
            mostrarMano "${manoDealer[@]}"
        else
            break
        fi
    done

    # Comparar manos
    mostrarSeparador
    valorJugador=$(calcularValorMano "${manoJugador[@]}")
    valorDealer=$(calcularValorMano "${manoDealer[@]}")

    echo -e "\e[1mValor final de la mano del jugador: $valorJugador\e[0m"
    echo -e "\e[1mValor final de la mano del dealer: $valorDealer\e[0m"

    if (( valorDealer > 21 )) || (( valorJugador > valorDealer )); then
        mostrarResultado "¡El jugador gana!" "32"
    elif (( valorJugador < valorDealer )); then
        mostrarResultado "¡El dealer gana!" "31"
    else
        mostrarResultado "¡Empate!" "33"
    fi
    mostrarSeparador
}

# Preguntar si se quiere volver a jugar
while true; do
    jugarPartida
    read -p "¿Quieres volver a jugar? (s/n): " jugarDeNuevo
    if [[ ! "$jugarDeNuevo" =~ ^[sS]$ ]]; then
        clear
        break
    fi
    clear
done