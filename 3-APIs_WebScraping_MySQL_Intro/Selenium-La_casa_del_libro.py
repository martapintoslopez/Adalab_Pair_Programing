import pandas as pd 
from selenium import webdriver # Selenium es una herramienta para automatizar la interacción con navegadores web.
from webdriver_manager.chrome import ChromeDriverManager # ChromeDriverManager gestiona la instalación del controlador de Chrome.
from selenium.webdriver.common.keys import Keys # Keys es útil para simular eventos de teclado en Selenium.
from selenium.webdriver.support.ui import Select # Select se utiliza para interactuar con elementos <select> en páginas web.
from time import sleep # Sleep se utiliza para pausar la ejecución del programa por un número de segundos.
pd.set_option('display.max_columns', None) # Establece una opción de Pandas para mostrar todas las columnas de un DataFrame.
from bs4 import BeautifulSoup
import requests

#Inicializo el Chrome
driver = webdriver.Chrome() 

# Navega a la página web 
driver.get("https://www.casadellibro.com/")

#sleep(2)
#Bloqueamos la opcione de permitir notificaciones
#driver.find_element("css selector", "#onetrust-consent-sdk > div.onetrust-pc-dark-filter.ot-fade-in").click()

sleep(2)
#Aceptamos las cookies (podríamos poner la que no acepta)
driver.find_element("css selector", "#onetrust-accept-btn-handler").click()

sleep(3)
#Maximizamos ventana
#driver.maximize_window()

#Vamos a la página de libros de ficción
driver.find_element("css selector", "#app > div.v-application--wrap > div.when-mobile > div.cabecera.desktop > div.bottom-row > div > div > div:nth-child(2) > a").click()
sleep(4)
diccionario_libros = {"título": [], 
                        "autor": [], 
                        "precio": [], 
                        "editorial": [], 
                        "idioma": [], 
                        "páginas": []}

#Iteramos por las páginas
for pagina in range(1,6):
    print(pagina)
    #Iteramos por los libros
    for i in range(2,21):
        try:
            #Pinchamos en el libro:
            driver.find_element("css selector", f"#buscadorNF > div.col-md-9.col-12 > div > div.grid-view.mt-4 > div:nth-child({i}) > a > div > img").click()
            sleep(4)

            #Sacar info de los libros y la metemos al diccionario:
            # TÍTULO
            try: #En general: 
                titulo = driver.find_element("css selector", "#app > div.v-application--wrap > main > div > div > div > div:nth-child(3) > div > div.col-md-5.order-lg-2.col-12.order-1 > div > h1").text
            except: #Hay casos con distinto lugar para el título:
                titulo = driver.find_element("css selector", "#app > div.v-application--wrap > main > div > div > div > div:nth-child(4) > div > div.col-md-5.order-lg-2.col-12.order-1 > div > h1").text
            diccionario_libros["título"].append(titulo)
            sleep(1)

            # AUTOR
            try: #En general:
                autor = driver.find_element("css selector", "#app > div.v-application--wrap > main > div > div > div > div:nth-child(3) > div > div.col-md-5.order-lg-2.col-12.order-1 > div > div.text-h5.d-flex.flex-wrap.author.mb-2.justify-center.justify-sm-start").text
            except: #Hay casos con distinto lugar para el autor: 
                autor = driver.find_element("css selector", "#app > div.v-application--wrap > main > div > div > div > div:nth-child(4) > div > div.col-md-5.order-lg-2.col-12.order-1 > div > div.text-h5.d-flex.flex-wrap.author.mb-2.justify-center.justify-sm-start").text
            diccionario_libros["autor"].append(autor)
            sleep(1)
            
            # PRECIO
            try: #En general:
                precio = driver.find_element("css selector", "#app > div.v-application--wrap > main > div > div > div > div:nth-child(3) > div > div.border-left.col-md-4.col-12.order-3 > div > div:nth-child(3)").text
            except: #Hay casos con distinto lugar para el precio (puede ser porque no hay existencias):
                precio = driver.find_element("css selector", "#app > div.v-application--wrap > main > div > div > div > div:nth-child(4) > div > div.border-left.col-md-4.col-12.order-3 > div > div:nth-child(3)").text
            #     precio = driver.find_element("css selector", "#app > div.v-application--wrap > main > div > div > div > div:nth-child(4) > div > div.border-left.col-md-4.col-12.order-3 > div > div:nth-child(2) > div > div > div").text
            diccionario_libros["precio"].append(precio)
            sleep(1)

            # EDITORIAL
            try: #En general:                                   
                editorial = driver.find_element("css selector", "#app > div.v-application--wrap > main > div > div > div > div:nth-child(3) > div > div.col-md-5.order-lg-2.col-12.order-1 > div > div.d-none.d-md-inline > div:nth-child(1) > span:nth-child(1)").text
            except: #Hay casos con distinto lugar para la editorial
                editorial = driver.find_element("css selector", "#app > div.v-application--wrap > main > div > div > div > div:nth-child(4) > div > div.col-md-5.order-lg-2.col-12.order-1 > div > div.d-none.d-md-inline > div:nth-child(1) > span:nth-child(1)").text            
            diccionario_libros["editorial"].append(editorial)
            sleep(1)
            #Hacemos scroll para abajo porque algunos de los datos estaban dando error. Posiblemente no se cargaban.
            driver.execute_script("window.scrollTo(0,200)")
            sleep(3)
            
            # IDIOMA
            try: #En general:                                  #app > div.v-application--wrap > main > div > div > div > div:nth-child(7) > div > div:nth-child(2) > div > div:nth-child(3) > div:nth-child(2)
                idioma = driver.find_element("css selector", "#app > div.v-application--wrap > main > div > div > div > div:nth-child(7) > div > div:nth-child(2) > div > div:nth-child(3)").text
            except: #Hay casos con distinto lugar para el idioma
                idioma = driver.find_element("css selector", "#app > div.v-application--wrap > main > div > div > div > div:nth-child(8) > div > div:nth-child(2) > div > div:nth-child(3) > div:nth-child(2)").text
            diccionario_libros["idioma"].append(idioma)  
            sleep(1)

            # PÁGINAS
            try: #En general
                paginas = driver.find_element("css selector", "#app > div.v-application--wrap > main > div > div > div > div:nth-child(7) > div > div:nth-child(2) > div > div:nth-child(1)").text
            except: #Hay casos con distinto lugar para el número de páginas 
                paginas = driver.find_element("css selector", "#app > div.v-application--wrap > main > div > div > div > div:nth-child(8) > div > div:nth-child(2) > div > div:nth-child(1) > div:nth-child(2) > span").text
            finally:
                paginas = driver.find_element("css selector", "#app > div.v-application--wrap > main > div > div > div > div:nth-child(6) > div > div:nth-child(2) > div > div:nth-child(1) > div:nth-child(2)").text
            diccionario_libros["páginas"].append(paginas)
            sleep(1)
        except:
            continue
        #Volvemos a la página previa
        sleep(1)
        driver.back()
        sleep(6)

    print(diccionario_libros)
    
    #Pasamos de página:
    sleep(3)
    x = pagina + 1 #x nos marca la siguiente página para poder pasar a la siguiente
    print(x)
    driver.find_element("css selector", f"#buscadorNF > div.col-md-9.col-12 > div > div:nth-child(4) > div > div > nav > ul > li:nth-child({x}) > button").click()
    sleep(2)
#Cerramos el navegador
driver.close()