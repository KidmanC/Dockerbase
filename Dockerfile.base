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

# Copiar el script de benchmark
COPY run-benchmarks.sh .
RUN chmod +x run-benchmarks.sh

# Script de entrada
CMD ["sh", "-c", "\
    # Iniciar el daemon de Docker\
    dockerd & \
    echo 'Esperando que el daemon de Docker esté disponible...' && \
    until docker info > /dev/null 2>&1; do sleep 1; done && \
    echo 'Docker está listo' && \
    ./run-benchmarks.sh\
"]