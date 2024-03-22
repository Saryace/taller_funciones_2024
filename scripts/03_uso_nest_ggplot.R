
# Cargamos librerias ------------------------------------------------------

library(tidyverse)
library(broom)
library(glue)

# Podemos usar los datos que extraimos antes en un ggplot -----------------

datos_pinguinos %>%
  drop_na(sexo) %>%
  ggplot(aes(x = largo_aleta_mm, y = masa_corporal_g)) +
  geom_point() +
  geom_smooth(method = "lm") +
  geom_text(data = datos_stat_limpios,
            aes(
              x = 230, # posicion arbitraria
              y = 2900, # posicion arbitraria
              hjust = 1,
              label = etiqueta
            )) +
  facet_wrap(vars(isla, sexo)) + # no repetir plots, mejor facet
  theme_bw()

# Otra forma, crear funciones ggplot --------------------------------------

ggplot_funcion_corr = function(x, y) {
  ggplot(datos_pinguinos %>% drop_na(sexo), aes(x = .data[[x]], y = .data[[y]]) ) +
    geom_point() +
    geom_smooth(method = "lm", se = FALSE) +
    theme_bw()
}

ggplot_funcion_boxplot = function(x, y) {
  ggplot(datos_pinguinos %>% drop_na(sexo), aes(x = .data[[x]], y = .data[[y]]) ) +
    geom_boxplot() +
    theme_bw()
}

# La puedo aplicar a cualquier columna de datos_pinguinos -----------------

ggplot_funcion_corr(x = "largo_aleta_mm", y = "masa_corporal_g")

ggplot_funcion_corr(x = "largo_aleta_mm", y = "alto_pico_mm")

# Ahora para boxplot ------------------------------------------------------

ggplot_funcion_boxplot(x = "sexo", y = "masa_corporal_g") 

ggplot_funcion_boxplot(x = "isla", y = "masa_corporal_g")


# Veamos por isla y sexo --------------------------------------------------

boxplots <- map(c("especie","isla","sexo"), #vector, .x en la funcion map
                 ~ggplot_funcion_boxplot(.x, "masa_corporal_g")) #.f

boxplots[2] # son tres

# los nombres de archivo los definimos para guardar los datos

iwalk(boxplots, ~ ggsave(paste0("mis_ggplots/ggplot_", .y, ".png"),
                      plot = .x))

