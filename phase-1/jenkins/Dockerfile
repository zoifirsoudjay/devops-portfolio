FROM jenkins/jenkins:lts

USER root

# Installe ca-certificates et met à jour le truststore Java
RUN apt-get update && apt-get install -y \
    ca-certificates \
    curl \
    && update-ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Crée le dossier security si absent
RUN mkdir -p /opt/java/openjdk/lib/security

# Copie le truststore système dans le JDK Jenkins
RUN cp /etc/ssl/certs/java/cacerts \
    /opt/java/openjdk/lib/security/cacerts 2>/dev/null || \
    keytool -genkey -alias temp -keystore \
    /opt/java/openjdk/lib/security/cacerts \
    -storepass changeit -noprompt \
    -dname "CN=temp" && \
    keytool -delete -alias temp \
    -keystore /opt/java/openjdk/lib/security/cacerts \
    -storepass changeit

# Importe les certificats Let's Encrypt (utilisés par Jenkins update center)
RUN curl -s https://letsencrypt.org/certs/lets-encrypt-r3.pem \
    -o /tmp/lets-encrypt-r3.pem && \
    keytool -import -trustcacerts \
    -alias lets-encrypt-r3 \
    -file /tmp/lets-encrypt-r3.pem \
    -keystore /opt/java/openjdk/lib/security/cacerts \
    -storepass changeit -noprompt || true

RUN curl -s https://letsencrypt.org/certs/isrgrootx1.pem \
    -o /tmp/isrgrootx1.pem && \
    keytool -import -trustcacerts \
    -alias isrg-root-x1 \
    -file /tmp/isrgrootx1.pem \
    -keystore /opt/java/openjdk/lib/security/cacerts \
    -storepass changeit -noprompt || true

USER jenkins

ENV JAVA_OPTS="-Xms256m -Xmx512m \
    -Djavax.net.ssl.trustStore=/opt/java/openjdk/lib/security/cacerts \
    -Djavax.net.ssl.trustStorePassword=changeit"
