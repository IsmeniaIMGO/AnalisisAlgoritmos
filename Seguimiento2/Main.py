import bibtexparser
import os
import re
import nltk
from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize
from nltk.stem import PorterStemmer
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity
import numpy as np
from scipy.cluster.hierarchy import linkage, dendrogram, fcluster
import matplotlib.pyplot as plt
from collections import defaultdict

# Asegúrate de haber descargado los recursos de NLTK necesarios
nltk.download('stopwords')
nltk.download('punkt')
nltk.download('punkt_tab')

# Definir el diccionario de categorías y palabras clave
categorias_palabras_clave = {
    'Habilidades': ['Abstraction', 'Algorithm', 'Algorithmic thinking', 'Coding', 'Collaboration', 'Cooperation', 'Creativity', 'Critical thinking', 'Debug', 'Decomposition', 'Evaluation', 'Generalization', 'Logic', 'Logical thinking', 'Modularity', 'Patterns recognition', 'Problem solving', 'Programming'],
    'Conceptos Computacionales': ['Conditionals', 'Control structures', 'Directions', 'Events', 'Funtions', 'Loops', 'Modular structure', 'Parallelism', 'Sequences', 'Software/hardware', 'Variables'],
    'Actitudes Emocionales': ['Engagement', 'Motivation', 'Perceptions', 'Persistence', 'Self-efficacy', 'Self-perceived'],
    'Propiedades Psicométricas': ['Classical Test Theory - CTT', 'Confirmatory Factor Analysis - CFA', 'Exploratory Factor Analysis - EFA', 'Item Response Theory (IRT) - IRT', 'Reliability', 'Structural Equation Model - SEM', 'Validity'],
    'Herramienta de Evaluación': ['Beginners Computational Thinking test - BCTt', 'Coding Attitudes Survey - ESCAS', 'Collaborative Computing Observation Instrument', 'Competent Computational Thinking test - cCTt', 'Computational thinking skills test - CTST', 'Computational concepts', 'Computational Thinking Assessment for Chinese Elementary Students - CTA-CES', 'Computational Thinking Challenge - CTC', 'Computational Thinking Levels Scale - CTLS', 'Computational Thinking Scale - CTS', 'Computational Thinking Skill Levels Scale - CTS', 'Computational Thinking Test - CTt', 'Computational Thinking Test', 'Computational Thinking Test for Elementary School Students', 'Computational Thinking Test for Lower Primary - CTtLP', 'Computational thinking-skill tasks on numbers and arithmetic', 'Computerized Adaptive Programming Concepts Test - CAPCT', 'CT Scale - CTS', 'Elementary Student Coding Attitudes Survey - ESCAS', 'General self-efficacy scale', 'ICT competency test', 'Instrument of computational identity', 'KBIT fluid intelligence subtest', 'Mastery of computational concepts Test and an Algorithmic Test', 'Multidimensional 21st Century Skills Scale', 'Self-efficacy scale', 'STEM learning attitude scale', 'The computational thinking scale'],
    'Diseño de Investigación': ['No experimental', 'Experimental', 'Longitudinal research', 'Mixed methods', 'Post-test', 'Pre-test', 'Quasi-experiments'],
    'Nivel de Escolaridad': ['Upper elementary education - Upper elementary school', 'Primary school - Primary education - Elementary school', 'Early childhood education – Kindergarten -Preschool', 'Secondary school - Secondary education', 'high school - higher education', 'University – College'],
    'Medio Block Programming': ['Mobile application', 'Pair programming', 'Plugged activities', 'Programming', 'Robotics', 'Spreadsheet', 'STEM', 'Unplugged activities'],
    'Estrategia': ['Construct-by-self mind mapping', 'Construct-on-scaffold mind mapping', 'Design-based learning', 'Evidence-centred design approach', 'Gamification', 'Reverse engineering pedagogy', 'Technology-enhanced learning', 'Collaborative learning', 'Cooperative learning', 'Flipped classroom', 'Game-based learning', 'Inquiry-based learning', 'Personalized learning', 'Problem-based learning', 'Project-based learning', 'Universal design for learning'],
    'Herramienta': ['Alice', 'Arduino', 'Scratch', 'ScratchJr', 'Blockly Games', 'Code.org', 'Codecombat', 'CSUnplugged', 'Robot Turtles', 'Hello Ruby', 'Kodable', 'LightbotJr', 'KIBO robots', 'BEE BOT', 'CUBETTO', 'Minecraft', 'Agent Sheets', 'Mimo', 'Py– Learn', 'SpaceChem']
}

def cargar_abstracts_desde_bib(directorio):
    """
    Carga los abstracts desde los archivos .bib en el directorio especificado y clasifica las palabras clave.

    Args:
        directorio (str): Directorio que contiene los archivos .bib.

    Returns:
        list: Una lista de diccionarios, donde cada diccionario contiene
              el título, el abstract y las palabras clave clasificadas de un artículo.
    """
    abstracts = []
    for nombre_archivo in os.listdir(directorio):
        if nombre_archivo.endswith(".bib"):
            ruta_archivo = os.path.join(directorio, nombre_archivo)
            try:
                with open(ruta_archivo, 'r', encoding='utf-8') as archivo_bibtex:
                    parser = bibtexparser.bparser.BibTexParser(common_strings=True)
                    base_datos_bib = bibtexparser.load(archivo_bibtex, parser=parser)
                    for entrada in base_datos_bib.entries:
                        if 'abstract' in entrada and 'title' in entrada:
                            # Extraer las palabras clave y asegurarse de que sea una lista
                            palabras_clave = entrada.get('keywords', '').split(',')
                            palabras_clave = [k.strip() for k in palabras_clave]  # Limpiar espacios en blanco

                            # Clasificar las palabras clave
                            palabras_clave_clasificadas = {}
                            for categoria, palabras_clave_categoria in categorias_palabras_clave.items():
                                palabras_clave_clasificadas[categoria] = [palabra_clave for palabra_clave in palabras_clave if palabra_clave in palabras_clave_categoria]

                            abstracts.append({
                                'titulo': entrada['title'],
                                'abstract': entrada['abstract'],
                                'palabras_clave': palabras_clave_clasificadas
                            })
            except Exception as e:
                print(f"Error al procesar {nombre_archivo}: {e}")
    return abstracts

def preprocesar_texto(texto):
    """
    Limpia, tokeniza y aplica stemming a un texto.

    Args:
        texto (str): El texto a preprocesar.

    Returns:
        str: El texto preprocesado.
    """
    # Eliminar puntuación
    texto = re.sub(r'[^\w\s]', '', texto)

    # Convertir a minúsculas
    texto = texto.lower()

    # Tokenizar
    tokens = word_tokenize(texto)

    # Eliminar stopwords
    palabras_vacias = set(stopwords.words('english'))
    tokens = [token for token in tokens if token not in palabras_vacias]

    # Aplicar stemming
    stemmer = PorterStemmer()
    tokens = [stemmer.stem(token) for token in tokens]

    # Unir los tokens de nuevo en un texto
    texto = ' '.join(tokens)

    return texto

def calcular_pureza(clusters, abstracts):
    """
    Calcula la pureza de los clusters.

    Args:
        clusters (list of lists): Lista de clusters, donde cada cluster es una lista de índices de abstracts.
        abstracts (list): Lista de diccionarios de abstracts, donde cada diccionario contiene las palabras clave clasificadas.

    Returns:
        float: La pureza de los clusters.
    """
    total_pureza = 0
    num_abstracts = len(abstracts)

    for indices_cluster in clusters:
        # Contar las categorías de palabras clave más frecuentes en el cluster
        conteo_categorias = defaultdict(int)
        for i in indices_cluster:
            for categoria, palabras_clave in abstracts[i]['palabras_clave'].items():
                if palabras_clave:  # Si hay palabras clave en esta categoría
                    conteo_categorias[categoria] += 1

        # Calcular la categoría más frecuente en el cluster
        if conteo_categorias:
            categoria_maxima = max(conteo_categorias, key=conteo_categorias.get)
            conteo_maximo = conteo_categorias[categoria_maxima]
        else:
            conteo_maximo = 0  # Si no hay categorías, el conteo máximo es 0

        # Sumar el conteo máximo a la pureza total
        total_pureza += conteo_maximo

    # Calcular la pureza promedio
    pureza = total_pureza / num_abstracts
    return pureza

if __name__ == '__main__':
    directorio_recursos = r'C:\Users\Ismenia Guevara\Documents\Repositorios GIT\PracticasAnalisisAlgoritmos\Seguimiento2\recursos'
    abstracts = cargar_abstracts_desde_bib(directorio_recursos)

    # Preprocesar los abstracts
    abstracts_preprocesados = []
    for abstract in abstracts:
        texto_preprocesado = preprocesar_texto(abstract['abstract'])
        abstracts_preprocesados.append({
            'titulo': abstract['titulo'],
            'abstract': texto_preprocesado,
            'palabras_clave': abstract['palabras_clave']
        })

    # Vectorizar los abstracts usando TF-IDF
    vectorizador = TfidfVectorizer()
    matriz_tfidf = vectorizador.fit_transform([abstract['abstract'] for abstract in abstracts_preprocesados])

    # Calcular la matriz de similitud del coseno
    matriz_similitud = cosine_similarity(matriz_tfidf)

    # 4. Implementación de dos algoritmos de clustering jerárquico
    # Utilizaremos scipy.cluster.hierarchy para implementar el clustering jerárquico

    # 4.1 Algoritmo 1: Enlace completo (complete linkage)
    # Usaremos la matriz de similitud y el método 'complete' de scipy
    enlace_completo = linkage(matriz_tfidf.toarray(), 'complete')

    # 4.2 Algoritmo 2: Enlace promedio (average linkage)
    # Usaremos la matriz de similitud y el método 'average' de scipy
    enlace_promedio = linkage(matriz_tfidf.toarray(), 'average')

    # 5. Visualización con dendrogramas
    # 5.1 Usar matplotlib para construir y visualizar los dendrogramas

    # Dendrograma para el enlace completo
    plt.figure(figsize=(12, 6))
    dendrogram(enlace_completo,
                orientation='top',
                labels=[abstract['titulo'] for abstract in abstracts_preprocesados],  # Etiquetas con los títulos de los abstracts
                distance_sort='descending',
                show_leaf_counts=True)
    plt.title('Dendrograma - Enlace Completo')
    plt.xlabel('Abstracts')
    plt.ylabel('Distancia')
    plt.xticks(fontsize=8, rotation=90)  # Ajustar el tamaño y la rotación de las etiquetas
    plt.tight_layout()  # Ajustar el diseño para evitar que las etiquetas se superpongan
    plt.show()

    # Dendrograma para el enlace promedio
    plt.figure(figsize=(12, 6))
    dendrogram(enlace_promedio,
                orientation='top',
                labels=[abstract['titulo'] for abstract in abstracts_preprocesados],  # Etiquetas con los títulos de los abstracts
                distance_sort='descending',
                show_leaf_counts=True)
    plt.title('Dendrograma - Enlace Promedio')
    plt.xlabel('Abstracts')
    plt.ylabel('Distancia')
    plt.xticks(fontsize=8, rotation=90)  # Ajustar el tamaño y la rotación de las etiquetas
    plt.tight_layout()  # Ajustar el diseño para evitar que las etiquetas se superpongan
    plt.show()

    # 6. Evaluación de la coherencia de los agrupamientos
    # 6.1 Definir una métrica de evaluación (pureza)
    # 6.2 Comparar las agrupaciones con las categorías derivadas de las palabras clave
    # 6.3 Determinar cuál de los dos algoritmos produce agrupamientos más coherentes

    # Cortar los dendrogramas para obtener clusters
    num_clusters = 3  # Define el número de clusters
    clusters_completo = fcluster(enlace_completo, t=num_clusters, criterion='maxclust')
    clusters_promedio = fcluster(enlace_promedio, t=num_clusters, criterion='maxclust')

    # Convertir los resultados de fcluster a listas de índices
    def crear_lista_clusters(etiquetas_cluster):
        clusters = [[] for _ in range(num_clusters)]
        for i, etiqueta in enumerate(etiquetas_cluster):
            clusters[etiqueta - 1].append(i)
        return clusters

    clusters_completo_lista = crear_lista_clusters(clusters_completo)
    clusters_promedio_lista = crear_lista_clusters(clusters_promedio)

    # Calcular la pureza para cada algoritmo
    pureza_completo = calcular_pureza(clusters_completo_lista, abstracts_preprocesados)
    pureza_promedio = calcular_pureza(clusters_promedio_lista, abstracts_preprocesados)

    # Imprimir los resultados
    print(f"Pureza para el algoritmo de enlace completo: {pureza_completo:.4f}")
    print(f"Pureza para el algoritmo de enlace promedio: {pureza_promedio:.4f}")

    # Determinar cuál algoritmo produce agrupamientos más coherentes
    if pureza_completo > pureza_promedio:
        print("El algoritmo de enlace completo produce agrupamientos más coherentes.")
    elif pureza_promedio > pureza_completo:
        print("El algoritmo de enlace promedio produce agrupamientos más coherentes.")
    else:
        print("Ambos algoritmos producen agrupamientos con la misma coherencia.")