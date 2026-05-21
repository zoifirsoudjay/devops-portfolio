# ================================
# Stage 1 : tests
# ================================
FROM python:3.12-slim AS test

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY src/ ./src/
COPY tests/ ./tests/

# Lance les tests — si ca echoue, le build s'arrete ici
RUN pytest tests/ -v

# ================================
# Stage 2 : production
# ================================
FROM python:3.12-slim AS prod

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copie uniquement le code source, pas les tests
COPY src/ ./src/

EXPOSE 5000

CMD ["python", "src/main.py"]