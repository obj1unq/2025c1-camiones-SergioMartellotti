# Camión de transporte

Una empresa de transporte quiere administrar mejor las cargas que lleva un camión.

Para eso requiere un sistema que le permita planificar qué cosas debe llevar el camión sin sobrepasar su capacidad a un destino capaz de recibir la carga. Por otro lado, las cosas que transporta tienen un nivel de peligrosidad. Este nivel es usado para impedir que cosas que superen cierto nivel de peligrosidad circulen en determinadas rutas.

## El camión
Se pide que el camión entienda los siguientes mensajes:

* `cargar(cosa)` y `descargar(cosa)`: para manejar qué tiene.
* `todoPesoPar()`: si el peso de cada uno de los objetos cargados es un número par.
* `hayAlgunoQuePesa(peso)`: indica si hay alguno de los objetos cargados que tiene exactamente el peso indicado.
* `elDeNivel(nivel)`: devuelve el primer objeto cargado que encuentre, cuyo nivel de peligrosidad coincida exactamente con el valor indicado.   
* `pesoTotal()`: es la suma del peso del camión vacío (tara) y su carga. La tara del camión es de 1000 kilos.
* `excedidoDePeso()`: indica si el peso total es superior al peso máximo, que es de 2500 kilos.
* `objetosQueSuperanPeligrosidad(nivel)`: devuelve una colección con los objetos cargados que superan el nivel de peligrosidad indicado.
* `objetosMasPeligrososQue(cosa)`: devuelve una colección con los objetos cargados que son más peligrosos que la cosa indicada.
* `puedeCircularEnRuta(nivelMaximoPeligrosidad)` Puede circular si no está excedido de peso, y además, ninguno de los objetos cargados supera el nivel máximo de peligrosidad indicado.

## Las cosas
De las cosas que puede transportar el camión nos interesa el peso y la peligrosidad:

* Knight Rider: pesa 500 kilos y su nivel de peligrosidad es 10.
* Bumblebee: pesa 800 kilos y su nivel de peligrosidad es 15 si está transformado en auto o 30 si está como robot.
* Paquete de ladrillos: cada ladrillo pesa 2 kilos, la cantidad de ladrillos que tiene puede variar. La peligrosidad es 2.
* Arena a granel: el peso es variable, la peligrosidad es 1.
* Batería antiaérea : el peso es 300 kilos si está con los misiles o 200 en otro caso. En cuanto a la peligrosidad es 100 si está con los misiles y 0 en otro caso.
* Contenedor portuario: un contenedor puede tener otras cosas adentro. El peso es 100 + la suma de todas las cosas que estén adentro. Es tan peligroso como el objeto más peligroso que contiene. Si está vacío, su peligrosidad es 0.
* Residuos radioactivos: el peso es variable y su peligrosidad es 200.
* Embalaje de seguridad: es una cobertura que envuelve a cualquier otra cosa. El peso es el peso de la cosa que tenga adentro. El nivel de peligrosidad es la mitad del nivel de peligrosidad de lo que envuelve.

## Agregados al camión
Se pide agregar estos mensajes al camión:

* `tieneAlgoQuePesaEntre(min, max)`: indica si el peso de alguna de las cosas que tiene el camión está en ese intervalo;
* `cosaMasPesada()`: la cosa más pesada que tenga el camión. Ojo que lo que se pide es _la cosa_ y no su peso.
* `pesos()`: devuelve una lista con _los pesos_ de cada cosa que tiene el camión.
* `totalBultos()`: la suma de la cantidad de bultos que está transportando. KnightRider, arena a granel y residuos radioactivos son 1 bulto. Bumblebee y embalaje de seguridad son dos. Paquete de ladrillos es 1 hasta 100 ladrillos, 2 de 101 a 300, 3 301 o más. Batería antiaérea: 1 si no tiene misiles, 2 si tiene. Contenedor portuario: 1 + los bultos que tiene adentro.

## Consecuencias de la carga.


- KnightRider: no hace nada;
- Bumblebee: pasa a robot;
- paquete de ladrillos: agrega 12 ladrillos;
- arena a granel: agrega 20 kilos;
- batería antiaérea: carga misiles;
- contenedor portuario: hace que reaccione cada una de las cosas que tiene adentro;
- residuos radioactivos: agrega 15 kilos;
- embalaje de seguridad: nada.

## Transporte.

El camión de transporte transporta los elementos al almacén. Al llegar al almacén, todas las cosas que están en el camión pasan al almacén: 
Por ejemplo, si el camión tiene a knigth Rider y a Bumblebee, mientras que  el almacén está la arena a granel, cuando el camión 
llega éste queda vacío y en el almacén quedan bumblebee, arena a grandel y Knigth Rider.

El viaje puede ser por la ruta 9 o por caminos vecinales. Esta elección se hace al momento de realizar el transporte.

Para que el transporte pueda ser realizado debe cumplirse con las siguientes condiciones:
* El camión no tiene que estar excedido de peso
* El almacén tiene una cantidad de bultos máximos que no puede superar. Por ejemplo, si contiene arena a granel (1 bulto), el máximo de bultos
del almacén se configura en 3, y el camión contiene a Bumblebee y Knight Rider (3 bultos), entonces no se puede transportar.
* El camino soporte el viaje:
	* El nivel de peligrosidad de la ruta 9 es 11, solo se puede usar la ruta 9 en los casos en "puedaCircularEnRuta" del punto 1
	* Los caminos vecinales tienen un peso máximo soportado que es configurable. El peso total del camión no puede ser superior al peso tolerado


Se pide que el camión entienda el mensaje `transportar(destino, camino)` Donde destino es el almacén (pero se parametriza porque podría
aparecer otros lugares) y el camino es una de las dos opciones (ruta 9 o caminos vecinales, pero también se debe pensar que pueda haber otros caminos
polimórficos).

Es importante realizar las validaciones correspondientes.