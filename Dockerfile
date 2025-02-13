FROM docker:dind

# Instalar herramientas necesarias
RUN apk add --no-cache \
    git \
    bash \
    python3 \
    openjdk17 \
    nodejs \
    npm \
    rust \
    cargo

# Establecer el directorio de trabajo
WORKDIR /app

# Script de entrada que clonará el repositorio y ejecutará el benchmark
CMD ["sh", "-c", "\
    # Iniciar el daemon de Docker\
    dockerd & \
    echo 'Esperando que el daemon de Docker esté disponible...' && \
    until docker info > /dev/null 2>&1; do sleep 1; done && \
    echo 'Docker está listo' && \
    # Clonar el repositorio con los benchmarks\
    git clone https://github.com/KidmanC/Docker . && \
    # Ejecutar el benchmark\
    chmod +x run-benchmarks.sh && \
    ./run-benchmarks.sh\
"]