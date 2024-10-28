install.packages("countrycode")
install.packages("remotes")
library(remotes)
install_github('vincentarelbundock/countrycode')
library(sf)
library(jsonlite)
library(tidyverse)
library(dplyr)
# 读取 JSON 文件
gddf <- fromJSON("/Users/xiaoqianmai/Desktop/GIS/week4/hmwk/hdr-data.json")
'''
gddf2010 <- gddf %>%
  filter(year==2010)
gddf2019 <- gddf %>%
  filter(year==2019)
'''
sf <-read_sf("/Users/xiaoqianmai/Desktop/GIS/week4/hmwk/World_Countries_(Generalized)_2402777631520798174/World_Countries_Generalized.shp")
#把iso换为3位代码
library(countrycode)
sf3<- countrycode(sf$ISO, origin = 'iso2c', destination = 'iso3c')


gddfw <-gddf %>%
  pivot_wider(.,names_from = "year",values_from = "value" ) %>%
  left_join(.,sf3,by=c("countryIsoCode"="ISO")) %>%
  mutate(difference = `2019`-`2010`)

