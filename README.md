#Topologoscopio

Este proyecto corresponde al trabajo presentado por la e[ad] Escuela de Arquitectura y Diseño PUCV a la muestra "Work in Progress" realizada en la Facultad de Arquitectura y Estudios Urbanos PUC.

Esta aplicación consta de 2 partes:
1. Un documento HTML que hace uso de la API de reconocimiento de voz. Para que funcione correctamente debe ser visualizado en Chrome en un servidor local. Para evitar el problema de la autorización que solicita el navegador para acceder al micrófono se recomienda usar SSL
2. Una aplicación en Processing para comunicarse con el documento HTML (vía Websocket), renderizar los textos recibidos y almacenarlos en una base de datos local.
