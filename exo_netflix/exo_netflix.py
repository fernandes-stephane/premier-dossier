import pandas as pd

data = pd.read_csv("/home/simplon/Téléchargements/netflix_titles.csv", index_col=[0])


"""
print(data)
data2 = data.head()

print(data2)
data3 = data.shape

print(data3)


film = data.loc[data["type"] == "Movie", "type"].value_counts()
serie = data.loc[data["type"] == "TV Show", "type"].value_counts()


print(film)
print(serie)


data4 =  data.describe(include= "all")
print(data4)




data5 = data.isna().sum()
print(data5)





direct = data.loc[data["director"].isna()]




# correction:
print(direct.type.value_counts())




print(direct.loc[direct["type"] == "Movie", "type"].value_counts())
print(direct.loc[direct["type"] == "TV Show", "type"].value_counts())


wa = data.loc[data.cast.isna()]


print(wa.listed_in.value_counts().head(10))

dup = data.duplicated()
print(dup)

drop = data.drop_duplicates()
print(drop)

france = data[data["country"]=="France"]
print(france)

us = data[data["country"]=="United States"]
print(us)

print(france.shape, us.shape)

annee = data.release_year.min()
print(annee)

# correction :
data_older = data.loc[data.release_year == data.release_year.min(), ["title", "release_year"]]
print(data_older)




# correction :

#9. Afficher le contenu le plus vieux disponible sur Netflix
data_older = data.loc[data.release_year == data.release_year.min(), ['title', 'release_year']]
print(data_older)
#10. Afficher le film avec la durée la plus longue sur Netflix
#Afficher les 5 films les + long(juste la durée)
data_movies = data.loc[data.type == 'Movie']
duree = pd.Series(data_movies['duration']).str.replace(" min", "").astype('int').sort_values(ascending=False).head(5)
print(duree)

#Affiche les 5 films avec toutes les infos(version merge & series)
data_movies = data.loc[data.type == 'Movie']
duree = pd.Series(data_movies['duration']).str.replace(" min", "").astype('int').sort_values(ascending=False).head(5)
data_merged = pd.merge(data, duree.to_frame(), on='show_id', how='inner')
data_film_duration = data_merged.sort_values(by='duration_x', ascending=False).head(5)[["title", "duration_x"]]
print(data_film_duration)

#Affiche les 5 films avec toutes les infos
data["duration"] = pd.Series(data_movies['duration']).str.replace(" min", "").astype('int')
data_film_duration_2 = data.sort_values(by='duration', ascending=False).head(5)[["title", "duration"]]
print(data_film_duration_2)





# correction :
data["listed_in"].head(10)

# ", ".join(data["listed_in"].dropna())

categories = ", ".join(data["listed_in"].dropna()).split(", ")
categories =pd.Series(categories)
#print(categories)
print(categories.value_counts().head())





# ---------------12------------------------------
director = ", ".join(data["director"].dropna()).split(", ")
director =pd.Series(director)
print(director)
print(director.value_counts().head(10))
 

#-----------------13------------------------------

director2 = data.loc[data['director'].notna()]
print(director2)






#---------------14-----------------------------

import seaborn as sns 

"""











