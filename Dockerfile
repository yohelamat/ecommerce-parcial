FROM python:3.10-slim

WORKDIR /app

# Dependencias
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# App
COPY main.py .

EXPOSE 8080

CMD ["python", "main.py"]