#!/bin/bash

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

function ctrl_c(){
	echo -e "\n${redColour}[!] Saliendo...${endColour}\n"
  tput cnorm;	exit 1
}

#Ctrl+c
trap ctrl_c INT

function helpPanel() {
  echo -e "\n${yellowColour}[+]${endColour}${grayColour} Uso: ${endColour}${purpleColour}$0${endColour}\n" 
  echo -e "\t${blueColour}-m)${endColour}${grayColour} Dinero con el que se desea jugar${endColour}"
  echo -e "\t${blueColour}-t)${endColour}${grayColour} TÃ©cnica a utilizar: ${purpleColour}(${endColour}${yellowColour}martingala${endColour}${blueColour}/${endColour}${yellowColour}inverseLabrouchere${endColour}${purpleColour})${endColour}\n"
  exit 1
}

function martingala(){
  echo -e "\n${yellowColour}[+]${endColour}${grayColour} Dinero Actual: ${endColour}${yellowColour}$moneyâ‚¬${endColour}"
  echo -ne "${yellowColour}[+]${endColour}${grayColour} Â¿CuÃ¡nto dinero tiene pensado apostar? -> ${endColour}" && read initial_bet
  echo -ne "${yellowColour}[+]${endColour}${grayColour} Â¿A quÃ© deseas apostar continuamente {par/impar}? -> ${endColour}" && read par_impar
  echo -e "${yellowColour}[+]${endColour}${grayColour} Vamos a jugar con una cantidad incial de ${endColour}${yellowColour}$initial_betâ‚¬${endColour}${grayColour} a ${endColour}${yellowColour}$par_impar${endColour}\n"
  backup_bet=$initial_bet
  play_counter=0
  mala_jugadas="[ "
  max_reward=0

  tput civis #Ocultamos el cursor
  while true; do
    random_number="$(($RANDOM % 37))"
    money="$(($money - $initial_bet))";
    backup_money="$money"
#    echo -e "\n${yellowColour}[+]${endColour}${grayColour} Acabas de Apostar ${endColour}${yellowColour}$initial_bet${endColour}${grayColour} y tienes ${endColour}${yellowColour}$money${endColour}"

    if [ ! "$money" -lt 0 ]; then
      # Cuando se apuesta por nÃºmeros pares
      if [ "$par_impar" == "par" ]; then
        if [ "$(($random_number % 2))" -eq 0 ]; then
          if [ "$random_number" -eq 0 ]; then
#            echo -e "${yellowColour}[+]${endColour}${grayColour} Ha salido el nÃºmero ${endColour}${yellowColour}$random_number${endColour}"
#            echo -e "${redColour}[+] El $random_number es cero, por lo tanto perdemos${endColour}"
            initial_bet="$(($initial_bet * 2))"
#            echo -e "${yellowColour}[+]${endColour}${grayColour} Tienes ${endColour}${yellowColour}$moneyâ‚¬${endColour}"
            mala_jugadas+="$random_number "
          else
#            echo -e "${yellowColour}[+]${endColour}${grayColour} Ha salido el nÃºmero ${endColour}${yellowColour}$random_number${endColour}"
#            echo -e "${greenColour}[+] El nÃºmero ha salido par, !GanasteÂ¡${endColour}"
            reward="$(($initial_bet * 2))"
#            echo -e "${yellowColour}[+]${endColour}${grayColour} Ganas un total de ${endColour}${yellowColour}$rewardâ‚¬${endColour}"
            money="$(($money + $reward))"
#            echo -e "${yellowColour}[+]${endColour}${grayColour} Tienes ${endColour}${yellowColour}$moneyâ‚¬${endColour}"
            initial_bet=$backup_bet
            mala_jugadas="[ "
            if [ "$money" -gt "$backup_money"  ]; then
              max_reward=$money
            fi
          fi
        else
#          echo -e "${yellowColour}[+]${endColour}${grayColour} Ha salido el nÃºmero ${endColour}${yellowColour}$random_number${endColour}"
#          echo -e "${redColour}[+] El nÃºmero ha salido impar, !PerdisteÂ¡${endColour}"
          initial_bet="$(($initial_bet * 2))"
#          echo -e "${yellowColour}[+]${endColour}${grayColour} Tienes ${endColour}${yellowColour}$moneyâ‚¬${endColour}"
          mala_jugadas+="$random_number "
        fi
      # Cuando se apuesta por nÃºmeros impares  
      else
        if [ "$(($random_number % 2))" -eq 1 ]; then
#          echo -e "${yellowColour}[+]${endColour}${grayColour} Ha salido el nÃºmero ${endColour}${yellowColour}$random_number${endColour}"
#          echo -e "${greenColour}[+] El nÃºmero ha salido impar, !GanasteÂ¡${endColour}"
          reward="$(($initial_bet * 2))"
#          echo -e "${yellowColour}[+]${endColour}${grayColour} Ganas un total de ${endColour}${yellowColour}$rewardâ‚¬${endColour}"
          money="$(($money + $reward))"
#          echo -e "${yellowColour}[+]${endColour}${grayColour} Tienes ${endColour}${yellowColour}$moneyâ‚¬${endColour}"
          initial_bet=$backup_bet
          mala_jugadas="[ "
          if [ "$money" -gt "$backup_money"  ]; then
            max_reward=$money
          fi
        else
#           echo -e "${yellowColour}[+]${endColour}${grayColour} Ha salido el nÃºmero ${endColour}${yellowColour}$random_number${endColour}"
#           echo -e "${redColour}[+] El nÃºmero ha salido par, !PerdisteÂ¡${endColour}"
            initial_bet="$(($initial_bet * 2))"
#           echo -e "${yellowColour}[+]${endColour}${grayColour} Tienes ${endColour}${yellowColour}$moneyâ‚¬${endColour}"
            mala_jugadas+="$random_number "
        fi 
      fi
    else
      mala_jugadas+="]"
      echo -e "${redColour}[!] Te has quedado sin dinero para seguir apostando, !has perdidoÂ¡${endColour}"
      echo -e "${yellowColour}[+]${endColour}${grayColour} Has alcanzado un mÃ¡ximo de ingresos de ${endColour}${greenColour}$max_rewardâ‚¬${endColour}"
      echo -e "${yellowColour}[+]${endColour}${grayColour} Han habido un total de ${endColour}${yellowColour}$play_counter${endColour}${grayColour} jugadas${endColour}"
      echo -e "${yellowColour}[+]${endColour}${grayColour} A continuaciÃ³n se van presentar las malas jugadas consecutivos que han salido:${endColour}"
      echo -e "\n${blueColour}$mala_jugadas${endColour}\n"
      tput cnorm; exit 0
    fi
    let play_counter+=1
  done
  tput cnorm #Regresamos el cursor

}

function inverseLabrouchere(){
  echo -e "\n${yellowColour}[+]${endColour}${grayColour} Dinero Actual: ${endColour}${yellowColour}$moneyâ‚¬${endColour}"
  echo -ne "${yellowColour}[+]${endColour}${grayColour} Â¿A quÃ© deseas apostar continuamente {par/impar}? -> ${endColour}" && read par_impar

  declare -a my_sequence=(1 2 3 4)

  echo -e "\n${yellowColour}[+]${endColour}${grayColour} Comenzamos con la secuencia ${endColour}${greenColour}[${my_sequence[@]}]${endColour}"

  bet=$((${my_sequence[0]} + ${my_sequence[-1]}))

  jugadas_totales=0
  bet_to_renew=$(($money + 50))
  echo -e "\n${yellowColour}[+]${endColour}${grayColour} Se ha establecido el tope para renovar la secuencia en ${endColour}${yellowColour}$bet_to_renewâ‚¬${endColour}\n"

  tput civis
  while true; do

    if [ $money -gt $bet_to_renew ]; then
      let bet_to_renew+=50
      echo -e "\n${yellowColour}[+]${endColour}${grayColour} Se ha actualizado el tope establecido para renovar la secuencia en ${endColour}${yellowColour}$bet_to_renewâ‚¬${endColour}\n"
      my_sequence=(1 2 3 4)
      bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
      echo -e "${yellowColour}[+]${endColour}${grayColour} Nuestra nueva secuencia es ${endColour}${greenColour}[${my_sequence[@]}]${endColour}"
    elif [ $money -lt $(($bet_to_renew - 100)) ]; then
      echo -e "${yellowColour}[+]${endColour}${grayColour} Hemos llegado a un tope critico ${endColour}${redColour}[$bet_to_renewâ‚¬]${endColour}${grayColour}, se procede a reajustar el top${endColour}"
      let bet_to_renew-=50
      echo -e "${yellowColour}[+]${endColour}${grayColour} Se ha renovado el tope a ${endColour}${yellowColour}$bet_to_renewâ‚¬${endColour}"

    fi

    let jugadas_totales+=1
    random_number=$(($RANDOM % 37))
    let money-=$bet

    echo -e "${yellowColour}[+]${endColour}${grayColour} Inviertes ${endColour}${yellowColour}$betâ‚¬${endColour}"
    echo -e "${yellowColour}[+]${endColour}${grayColour} Tienes ${endColour}${yellowColour}$moneyâ‚¬${endColour}"
    if [ ! "$money" -le 0 ]; then
      echo -e "\n${yellowColour}[+]${endColour}${grayColour} Ha salido el nÃºmero:${endColour}${yellowColour}$random_number${endColour}"

      if [ "$par_impar" == "par" ]; then

        if [ "$(($random_number % 2))" -eq 0 ] && [ "$random_number" -ne 0 ]; then
          echo -e "${yellowColour}[+]${endColour}${grayColour} El nÃºmero es par, !GanasÂ¡${endColour}"

          reward=$(($bet * 2))
          let money+=$reward
          echo -e "${yellowColour}[+]${endColour}${grayColour} Tienes ${endColour}${yellowColour}$moneyâ‚¬${endColour}"

          my_sequence+=($bet)
          my_sequence=(${my_sequence[@]})

          echo -e "${yellowColour}[+]${endColour}${grayColour} Nuestra nueva secuencia es ${endColour}${greenColour}[${my_sequence[@]}]${endColour}"

          if [ "${#my_sequence[@]}" -ne 1 ] && [ "${#my_sequence[@]}" -ne 0 ]; then
            bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
          elif [ "${#my_sequence[@]}" -eq 1 ]; then
            bet=${my_sequence[0]}
          else
            #falta llenar
            echo -e "${redColour}[!] Se resetea la secuencia${endColour}"
            my_sequence=(1 2 3 4)
            echo -e "${yellowColour}[+]${endColour}${grayColour} La secuencia quedarÃ­a de la siguiente forma: ${endColour}${greenColour}${my_sequence[@]}${endColour}"
            bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
          fi
        
        elif [ "$random_number" -eq 0 ] || [ "$(($random_number % 2))" -eq 1 ] ; then

          if [ "$random_number" -eq 0 ]; then
            echo -e "${redColour}[!] Ha salido el nÃºmero 0, por tanto !PierdesÂ¡${endColour}"
          else
            echo -e "${redColour}[!] El nÃºmero es impar, !PierdesÂ¡${endColour}"
          fi

          unset my_sequence[0]
          unset my_sequence[-1] 2>/dev/null
          
          my_sequence=(${my_sequence[@]})
          echo -e "${yellowColour}[+]${endColour}${grayColour} La secuencia quedarÃ­a de la siguiente forma: ${endColour}${greenColour}[${my_sequence[@]}]${endColour}"

          if [ "${#my_sequence[@]}" -ne 1 ] && [ "${#my_sequence[@]}" -ne 0 ]; then
            bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
          elif [ "${#my_sequence[@]}" -eq 1 ]; then
            bet=${my_sequence[0]}
          else
            #falta llenar
            echo -e "${redColour}[!] Se resetea la secuencia${endColour}"
            my_sequence=(1 2 3 4)
            echo -e "${yellowColour}[+]${endColour}${grayColour} La secuencia quedarÃ­a de la siguiente forma: ${endColour}${greenColour}[${my_sequence[@]}]${endColour}"
            bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
          fi
          
        fi
        
      elif [ "$par_impar" == "impar" ]; then

        if [ "$(($random_number % 2))" -eq 1 ]; then
          echo -e "${yellowColour}[+]${endColour}${grayColour} El nÃºmero es impar, !GanasÂ¡${endColour}"

          reward=$(($bet * 2))
          let money+=$reward
          echo -e "${yellowColour}[+]${endColour}${grayColour} Tienes ${endColour}${yellowColour}$moneyâ‚¬${endColour}"

          my_sequence+=($bet)
          my_sequence=(${my_sequence[@]})

          echo -e "${yellowColour}[+]${endColour}${grayColour} Nuestra nueva secuencia es ${endColour}${greenColour}[${my_sequence[@]}]${endColour}"

          if [ "${#my_sequence[@]}" -ne 1 ] && [ "${#my_sequence[@]}" -ne 0 ]; then
            bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
          elif [ "${#my_sequence[@]}" -eq 1 ]; then
            bet=${my_sequence[0]}
          else
            #falta llenar
            echo -e "${redColour}[!] Se resetea la secuencia${endColour}"
            my_sequence=(1 2 3 4)
            echo -e "${yellowColour}[+]${endColour}${grayColour} La secuencia quedarÃ­a de la siguiente forma: ${endColour}${greenColour}${my_sequence[@]}${endColour}"
            bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
          fi
        
        elif [ "$(($random_number % 2))" -eq 0 ] ; then

          if [ "$random_number" -eq 0 ]; then
            echo -e "${redColour}[!] Ha salido el nÃºmero 0, por tanto !PierdesÂ¡${endColour}"
          else
            echo -e "${redColour}[!] El nÃºmero es par, !PierdesÂ¡${endColour}"
          fi

          unset my_sequence[0]
          unset my_sequence[-1] 2>/dev/null
          
          my_sequence=(${my_sequence[@]})
          echo -e "${yellowColour}[+]${endColour}${grayColour} La secuencia quedarÃ­a de la siguiente forma: ${endColour}${greenColour}[${my_sequence[@]}]${endColour}"

          if [ "${#my_sequence[@]}" -ne 1 ] && [ "${#my_sequence[@]}" -ne 0 ]; then
            bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
          elif [ "${#my_sequence[@]}" -eq 1 ]; then
            bet=${my_sequence[0]}
          else
            #falta llenar
            echo -e "${redColour}[!] Se resetea la secuencia${endColour}"
            my_sequence=(1 2 3 4)
            echo -e "${yellowColour}[+]${endColour}${grayColour} La secuencia quedarÃ­a de la siguiente forma: ${endColour}${greenColour}[${my_sequence[@]}]${endColour}"
            bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
          fi
          
        fi
        
      fi

    else
      echo -e "\n${redColour}[!] Te has quedado sin dinero para seguir apostando, !has perdidoÂ¡${endColour}"
      echo -e "${yellowColour}[+]${endColour}${grayColour} Ha pasado un total de ${yellowColour}$jugadas_totales${endColour}${grayColour} jugadas totales${endColour}"
      tput cnorm; exit 1
    fi

#    sleep 1 

  done
  tput cnorm
}


while getopts 'm:t:h' arg; do
  case $arg in
    m) money="$OPTARG" ;;
    t) technique="$OPTARG" ;;
    h) helpPanel ;;
  esac
done

if [ "$money" ] && [ "$technique" ]; then
  if [ "$technique" == "martingala" ]; then
    martingala 
  elif [ "$technique" == "inverseLabrouchere" ]; then
    inverseLabrouchere
  else
    echo -e "\n${redColour}[!] La tÃ©cnica ingresada no existe${endColour}\n"
    helpPanel
  fi
else
  helpPanel
fi
