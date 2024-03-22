# Librerias ---------------------------------------------------------------

library(tidyverse) # se carga {purrr}

# Como repetir en R -------------------------------------------------------

diez_veces_diez <- c(10, 10, 10, 10, 10, 10, 10, 10, 10, 10)

diez_veces_diez <- rep(10, 10)

# Hacer secuencias --------------------------------------------------------

uno_al_diez <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)

uno_al_diez <- 1:10 #operador : de un num hasta otro, class integer

uno_al_diez <- seq(from = 1,
                   to = 10,
                   by = 1) #otra forma usando seq

# Creamos un dataframe ----------------------------------------------------

uno_al_diez_df <- tibble(datos = 1:10,
                         tipo = c("a", "a", "a", "a", "a",
                                  "b", "b", "b", "b", "b"))

uno_al_diez_df <- tibble(datos = 1:10,
                         tipo = rep(c("a","b"), each = 5))

rep(c("a","b"), times = 1, each = 5) # equivalente

# Repaso: tibbles son rectangulares ---------------------------------------

uno_al_diez_df <- tibble(datos = 1:12, # que pasa si es uno al doce
                         tipo = rep(c("a","b"), each = 5))

# Error in `tibble()`:
#   ! Tibble columns must have compatible sizes.
#  ℹ Only values of size one are recycled.

# Principio reciclaje -----------------------------------------------------

uno_al_diez_reciclaje <- tibble(datos = 1:10,
                         tipo = "esto se repetirá 10 veces")


# Listas ------------------------------------------------------------------

# Dataframes y tibbles pueden guardar diferentes tipos de datos en columnas
# 
# Las listas permiten contener cosas como dataframes,
# matrices y vectores en una misma variable.

# Creamos una lista -------------------------------------------------------

trencito <- list(vagon1 = 1:5,
                 vagon2 = "a",
                 vagon3 = 14:26,
                 vagon4 = 6:100)

trencito[1]

trencito$vagon3[3]

trencito[2]

trencito[[1]]

uno_al_diez_lista <- list(
  datos = 1:10,
  tipo = rep(c("a","b"), each = 5)
)

uno_al_doce_lista <- list(
  datos = 1:12,
  tipo = rep(c("a","b"), each = 5)
)

# Creamos una funcion -----------------------------------------------------

# creando una funcion con un argumento x que multiplique por 10

por_diez <- function(x) x*10 # funcion simple sin {}

por_diez(x = 10) # 10 por 10 

por_diez(uno_al_diez) # se aplica la funcion vectorizada

# Definiciones ------------------------------------------------------------

# funcion map()

# - Vector: `map()` aplicará la función a cada elemento del vector
# 
# - Lista:  `map()` aplicará la función a cada elemento de la lista
# 
# - Tibble `map()` aplicará la función a cada columna del dataframe


# Revisamos a funcion map() -----------------------------------------------

purrr::map(uno_al_diez, # vector
           por_diez) # funcion

purrr::map_dbl(uno_al_diez, por_diez) # dbl = output numeros

# purrr::map(uno_al_diez_lista, por_diez) # error!!!!

purrr::map(uno_al_diez_lista$datos, por_diez)

purrr::map_dbl(uno_al_diez_lista$datos, por_diez)

# Revisamos map2() --------------------------------------------------------

#funcion map2()

dataset_a <- c(3, 2 ,1)
dataset_b <- c(1, 2, 3)
dataset_c <- c(1, 2, 3, 4)

sumar_filas <- function(x, y) { x + y } # creando una nueva funcion

purrr::map2(dataset_a, dataset_b, sumar_filas)

purrr::map2_dbl(dataset_a, dataset_b, sumar_filas)

purrr::map2(dataset_a, dataset_c, sumar_filas) # que pasa

# Potencialidades ---------------------------------------------------------

#Loops: repetir una funcion o codigo un numero FIJO de veces

for (i in 1:5) {
  print(i)
}

# Como el primer valor de nuestra secuencia (1:5) es 1, el loop comienza
# sustituyendo i por 1 y ejecuta todo lo que hay entre los { }


# Puede ser otros nombres distintos a i -----------------------------------

for(enteros in c(1, 2, 3)) {
  print(enteros)
}

for(numero in 1:120) {
  print(numero)
}

# No solo funciones con numeros -------------------------------------------

nombres_clase <- c("Manuel", "Margarita", "Macarena")

for(nombre in nombres_clase) {
  print(nombre)
}

# Creamos una funcion en loop ---------------------------------------------

?paste

saludo_curso <- function(nombre) {
  paste("hola, ", nombre, "como estas?")
}

for (nombre in nombres_clase) {
  print(saludo_curso(nombre))
}

purrr::map(nombres_clase, saludo_curso)

purrr::map_chr(nombres_clase, saludo_curso)

# La funcion que quieras :) -----------------------------------------------

# install.packages("cowsay")

library(cowsay)

say(what = "texto aca", by = "alligator") #ver lista animales

say("hola", by = "ant") # argumentos de la funcion

# Interacion miau ---------------------------------------------------------

for(nombre in nombres_clase) {
  say(paste("hola", nombre), by = "cat")
}

# Funcion animal ----------------------------------------------------------

saludo_animal <-
function(nombre, animal) {
    say(paste("hola, ", nombre, "como estas?"), by = animal)
}

# Funciona o no funciona? -------------------------------------------------

saludo_animal(nombre = "Blanca",
              animal = "grumpycat")

saludo_animal(nombre = "Blanca",
              animal = c("grumpycat", "longcat"))

# Iteramos ----------------------------------------------------------------

nombres_clase <- c("Manuel", "Margarita", "Macarena")

animales <- c("ant", "longcat")

for(nombre in nombres_clase) {
  for (animal in animales) {
    saludo_animal(nombre, animal)
  }
}



