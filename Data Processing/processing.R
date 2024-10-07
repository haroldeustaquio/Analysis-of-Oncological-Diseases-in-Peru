
library(readr)
library(xlsx)
library(tidyverse)

# En excel, creamos la columna ID con una fórmula para que nos enumere los registros con documento anonimizado
# con el fin de tener más orden a la hora de mostrar los resultados, también eliminamos la columna de fecha de
# corte ya que no lo usaremos, modificamos también la columna MONTO_BRUTO para que al pasar a R lo reconozca 
# como numeric 


file.choose()
datos <- 
  read_csv2("J:\\Atenciones de Cobertura Oncológica\\Datos_sin_procesar\\DATA ATENCIONES ONCOLOGICAS 2022.csv")
# COMPARANDO LAS COLUMNAS REGION Y DEPARTAMENTO

table(datos$REGION)
table(datos$DEPARTAMENTO)

datos$MONTO_BRUTO <- NULL
datos$FECHA_ATENCION <- NULL
datos$FECHA_ALTA <- NULL
datos$FECHA_INTERNAMIENTO <- NULL

## Vemos que en departamento hay datos que faltan 

datos[datos$DEPARTAMENTO=='NULL',] %>%  view()

## Viendo que faltan datos en departamento, provincia, distrito, ubigeo para este IPRESS
datos[datos$IPRESS=='HOSPITAL CENTRAL DE MAJES ING. ANGEL GABRIEL CHURA GALLEGOS',] %>%  view()

## Corrigiendo el problema. buscando información en SEACE del gobierno
datos[datos$IPRESS=='HOSPITAL CENTRAL DE MAJES ING. ANGEL GABRIEL CHURA GALLEGOS',]$DEPARTAMENTO <- 'Arequipa'
datos[datos$IPRESS=='HOSPITAL CENTRAL DE MAJES ING. ANGEL GABRIEL CHURA GALLEGOS',]$PROVINCIA <- 'Caylloma'
datos[datos$IPRESS=='HOSPITAL CENTRAL DE MAJES ING. ANGEL GABRIEL CHURA GALLEGOS',]$DISTRITO <- 'Majes'
datos[datos$IPRESS=='HOSPITAL CENTRAL DE MAJES ING. ANGEL GABRIEL CHURA GALLEGOS',]$UBIGEO <- '040521'

## Volvemos a verificar y ahora replicaremos el proceso para el 
## IPRESS = INSTITUTO REGIONAL DE ENFERMEDADES NEOPLÁSICAS DEL CENTRO – IREN CENTRO

datos[datos$IPRESS=='INSTITUTO REGIONAL DE ENFERMEDADES NEOPLÁSICAS DEL CENTRO – IREN CENTRO',] %>%  view()

datos[datos$IPRESS=='INSTITUTO REGIONAL DE ENFERMEDADES NEOPLÁSICAS DEL CENTRO – IREN CENTRO',]$DEPARTAMENTO <- 'Junin'
datos[datos$IPRESS=='INSTITUTO REGIONAL DE ENFERMEDADES NEOPLÁSICAS DEL CENTRO – IREN CENTRO',]$PROVINCIA <- 'Concepcion'
datos[datos$IPRESS=='INSTITUTO REGIONAL DE ENFERMEDADES NEOPLÁSICAS DEL CENTRO – IREN CENTRO',]$DISTRITO <- 'Concepcion'
datos[datos$IPRESS=='INSTITUTO REGIONAL DE ENFERMEDADES NEOPLÁSICAS DEL CENTRO – IREN CENTRO',]$UBIGEO <- '120201'


## Reemplazando los valores de 0.0000 para que tenga 3 decimales y sea más fácil las operaciones

# Vemos que hay cantidades que superan los 8 millones, por esta razón eliminaremos esta columna porque nos puede dar resultados con amplio margen de error


table(datos$UBIGEO) %>%  view()

datos[datos$UBIGEO=='10101',]$UBIGEO <- '010101'
datos[datos$UBIGEO=='20101',]$UBIGEO <- '020101'
datos[datos$UBIGEO=='21801',]$UBIGEO <- '021801'
datos[datos$UBIGEO=='21809',]$UBIGEO <- '021809'
datos[datos$UBIGEO=='30101',]$UBIGEO <- '030101'
datos[datos$UBIGEO=='30201',]$UBIGEO <- '030201'

datos[datos$UBIGEO=='40101',]$UBIGEO <- '040101'
datos[datos$UBIGEO=='40201',]$UBIGEO <- '040201'
datos[datos$UBIGEO=='40401',]$UBIGEO <- '040401'
datos[datos$UBIGEO=='50101',]$UBIGEO <- '050101'
datos[datos$UBIGEO=='50115',]$UBIGEO <- '050115'
datos[datos$UBIGEO=='50501',]$UBIGEO <- '050501'

datos[datos$UBIGEO=='60101',]$UBIGEO <- '060101'

datos[datos$UBIGEO=='70102',]$UBIGEO <- '070102'
datos[datos$UBIGEO=='70103',]$UBIGEO <- '070103'
datos[datos$UBIGEO=='80101',]$UBIGEO <- '080101'
datos[datos$UBIGEO=='80106',]$UBIGEO <- '080106'
datos[datos$UBIGEO=='90101',]$UBIGEO <- '090101'


table(datos$FECHA_ATENCION) %>%  view()

datos[datos$PERIODO==202201,]$PERIODO <- 20220101
datos[datos$PERIODO==202202,]$PERIODO <- 20220201
datos[datos$PERIODO==202203,]$PERIODO <- 20220301
datos[datos$PERIODO==202204,]$PERIODO <- 20220401
datos[datos$PERIODO==202205,]$PERIODO <- 20220501
datos[datos$PERIODO==202206,]$PERIODO <- 20220601
datos[datos$PERIODO==202207,]$PERIODO <- 20220701
datos[datos$PERIODO==202208,]$PERIODO <- 20220801
datos[datos$PERIODO==202209,]$PERIODO <- 20220901
datos[datos$PERIODO==202210,]$PERIODO <- 20221001
datos[datos$PERIODO==202211,]$PERIODO <- 20221101
datos[datos$PERIODO==202212,]$PERIODO <- 20221201

datos %>%  view()

write.csv(datos,file="data_limpia.csv")
