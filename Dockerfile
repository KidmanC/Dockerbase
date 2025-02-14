FROM docker:dind

# Clona el primer repositorio
RUN git clone https://github.com/KidmanC/Docker /app

# Establece el directorio de trabajo
WORKDIR /app

# Da permisos de ejecución al script
RUN chmod +x run-benchmarks.sh

# Ejecuta el script al iniciar el contenedor
CMD ["./run-benchmarks.sh"]