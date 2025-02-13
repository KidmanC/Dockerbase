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

# Crear script de inicialización
RUN echo '#!/bin/sh\n\
# Iniciar dockerd en segundo plano\n\
dockerd --host=unix:///var/run/docker.sock --host=tcp://0.0.0.0:2375 &\n\
\n\
# Esperar a que el daemon esté disponible\n\
echo "Esperando al daemon de Docker..."\n\
while ! docker info >/dev/null 2>&1; do\n\
    sleep 1\n\
done\n\
\n\
echo "Docker está listo"\n\
\n\
# Clonar el repositorio\n\
git clone https://github.com/KidmanC/Docker .\n\
\n\
# Ejecutar el benchmark\n\
chmod +x run-benchmarks.sh\n\
./run-benchmarks.sh\n\
\n\
# Mantener el contenedor corriendo\n\
tail -f /dev/null' > /entrypoint.sh && \
    chmod +x /entrypoint.sh

# Usar el script de entrada
ENTRYPOINT ["/entrypoint.sh"]