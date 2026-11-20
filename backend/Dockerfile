
FROM python:3.11-slim

WORKDIR /app

# Install Node.js buat Tailwind CSS
RUN apt-get update && apt-get install -y nodejs npm && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Build CSS Tailwind
RUN if [ -f input.css ]; then npm install && npx tailwindcss -i ./input.css -o ./app/static/css/main.css; fi

RUN useradd -m appuser && chown -R appuser /app
USER appuser

EXPOSE 5000

CMD ["python", "run.py"]

