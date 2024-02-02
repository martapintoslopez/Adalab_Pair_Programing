#%%
import support_ETL as sup
import support_DDBB as sdb
import queries_soporte as query
import pandas as pd
#%%
lista_archivos = ["data/clientes.csv", "data/ventas.csv", "data/productos.csv"]
dicc = sup.lectura(lista_archivos)

# %%
for archivo in lista_archivos:
    
    nombre = archivo.split(".")[0]
    print(nombre.upper())
    sup.exploracion_dataframe(dicc[nombre])
    print("___________________________")

#%%
for key in dicc.keys():
    sup.col_minuscula(dicc[key])

# %%
df_productos= dicc["productos"].reset_index()
new_keys = ['id', 'nombre_producto', 'categoría', 'precio', 'origen', 'descripción', 'descripción 2']
sup.cambiar_columnas(df_productos, new_keys)

# %%
df_clientes = dicc["clientes"]
df_ventas = dicc["ventas"]
sup.columnas_cat(df_clientes)

df_productos["descripción 2"] = df_productos["descripción 2"].fillna("Unknown")

# %%
df = sup.mergear(df_clientes,df_ventas,df_productos)
# %%
sup.guardar_df(df, "csv_final.csv")

#%%
sdb.creacion_bbdd_tablas(query.query_creacion_bbdd, "AlumnaAdalab", "tienda_italia")
# %%
sdb.creacion_bbdd_tablas(query.query_tabla_tienda, "AlumnaAdalab")
# %%
#df[["id_cliente", "cantidad"]] = df[["id_cliente", "cantidad"]].applymap(sdb.change_to_int)

datos_para_tabla = list(zip(df["first_name"].values, df["last_name"].values,df["email"].values, df["gender"].values,df["city"].values, df["country"].values,df["address"].values,df["id_cliente"].values,df["id_producto"].values, df["fecha_venta"].values,df["cantidad"].values, df["total"].values,df["nombre_producto"].values, df["categoría"].values,df["precio"].values, df["origen"].values,df["descripción"].values, df["descripción 2"].values))
datos_para_tabla_limpios = []
for datos in datos_para_tabla:
    table_media = []
    for element in datos:
        try:
            table_media.append(float(element))
        except:
            table_media.append(element)
        
    datos_para_tabla_limpios.append(tuple(table_media))
    
#%%
sdb.insert_data(query.query_insert_table_tienda, "AlumnaAdalab", "tienda_italia", datos_para_tabla_limpios)
# %%
