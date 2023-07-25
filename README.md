# Ruleta.sh - Simulador de Ruleta de Casino

## Descripción
Este script en bash, llamado `ruleta.sh`, es un simulador de ruleta de casino que permite jugar utilizando dos técnicas diferentes: **Martingala** e **Inverse Labrouchere**. Ambas técnicas se utilizan comúnmente en estrategias de apuestas en juegos de azar. 

El programa solicita al usuario el dinero con el que desea jugar y la técnica que desea utilizar. Luego, simula las apuestas y el juego de la ruleta según la técnica elegida.

## Uso
Para utilizar el script, sigue los siguientes pasos:

1. Ejecuta el script en una terminal con el comando `bash ruleta.sh`.

2. El script mostrará las opciones disponibles para ingresar el dinero con el que deseas jugar y la técnica a utilizar.

3. Ingresa el monto de dinero con el que deseas comenzar el juego y selecciona una de las siguientes técnicas: **martingala** o **inverseLabrouchere**.

4. El script simulará el juego de ruleta de acuerdo con la técnica seleccionada y te mostrará los resultados de cada apuesta.

5. El juego continuará hasta que alcances un límite de dinero definido o te quedes sin dinero para apostar.

6. Al finalizar el juego, el script te proporcionará estadísticas sobre el total de jugadas realizadas y los montos máximos de ingresos alcanzados.

## Técnicas Disponibles
1. **Martingala**: Esta técnica se basa en duplicar la apuesta cada vez que se pierde, con el objetivo de recuperar las pérdidas y obtener una ganancia.

2. **Inverse Labrouchere**: Esta técnica utiliza una secuencia predefinida de números para determinar el monto de las apuestas. Cuando se gana, se eliminan los extremos de la secuencia; cuando se pierde, se agrega el último monto perdido al final de la secuencia.

## Advertencia
Recuerda que el juego de azar puede ser adictivo y potencialmente riesgoso para tus finanzas. Este script es solo una simulación y no garantiza ganancias reales. Utilízalo con responsabilidad y nunca apuestes más dinero del que estés dispuesto a perder.

## Autor
Este script fue desarrollado por Luis Ramos Moncayo.

¡Diviértete y apuesta con responsabilidad!
