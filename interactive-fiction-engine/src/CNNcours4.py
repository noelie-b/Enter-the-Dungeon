"""
Afficher la matrice de confusion avec ConfusionMatrix
Il faut réutiliser la fonction argmax pour obtenir les réponses, 
et ConfusionMatrix a besoin de numpy array
"""
# maxima = np.argmax(y_test, axis = 1)
# reponses = maxima.reshape(10000, 1)

# maxima_data = np.argmax(best_result, axis=1)
# result = maxima_data.reshape(10000, 1)

df_x = ps.DataFrame(predictions)
df_y = ps.DataFrame(y_test)

df = ps.DataFrame(df_x, columns=['y_Actual','y_Predicted'])
# print (df)
confusion_matrix = ps.crosstab(df['y_Actual'], df['y_Predicted'], rownames=['Actual'], colnames=['Predicted'])
print (confusion_matrix)


# -----------------------------------------------


drive.mount('/content/drive')

!mkdir CNN
!unzip

"""
liste_glob = glb("chemin/*") = donne intégralié fichier avec chemin
print(liste_glob)
for list_paths in glb:
  cv2.imread()
  
  nom_fichiers = liste_paths .split('/'0)[-1]
  print(nom_fichiers)
"""
# unsigned integer 8 bit e tmes changer de taille pour 28*28
