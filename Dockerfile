# Usa una imagen base que tenga soporte para múltiples lenguajes
FROM ubuntu:latest

# Instala las dependencias necesarias
RUN apt-get update && \
    apt-get install -y python3 openjdk-11-jdk nodejs npm \
    git curl && \
    curl -s https://get.sdkman.io | bash && \
    bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && sdk install kotlin" && \
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Clona el primer repositorio
RUN git clone <URL_DEL_PRIMER_REPOSITORIO> /app

# Establece el directorio de trabajo
WORKDIR /app

# Da permisos de ejecución al script
RUN chmod +x run-benchmarks.sh

# Ejecuta el script al iniciar el contenedor
CMD ["./run-benchmarks.sh"]