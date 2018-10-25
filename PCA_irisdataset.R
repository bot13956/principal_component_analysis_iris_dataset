# code to perform principal component analysis (PCA) in order to remove feature correlations

# author: Benjamin O. Tayo

# date: 10-25-2018

# import necessary libraries
library(GGally)
library(tidyverse)
library(readr)

# import dataset from uci.edu database

path<-"https://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data"
df<-read.csv(path)
names(df)<-c("sepal_length", "sepal_width","petal_length","petal_width", "class")
df%>%head()


# calculate covariance matrix 

df%>%select(-class)%>%cor()%>%round(3)

# visualize density plots, scatter plots, and correlation coefficients between original features

ggpairs(df,columns = c("sepal_length", "sepal_width","petal_length","petal_width"))

# perform PCA

pca <- prcomp(df[,1:4], scale. = TRUE)

# extract important components
summary(pca)

# calculate covariance matrix in PCA space

cor(pca$x[,1:4])%>%round(3)

# convert PCA matrix into a dataframe

pcdf<-as.data.frame(pca$x[,1:4])
names(pcdf)<-c("PC1", "PC2","PC3","PC4")

# visualize density plots, scatter plots, and correlation coefficients between transformed features
ggpairs(pcdf,columns = c("PC1", "PC2","PC3","PC4"))
