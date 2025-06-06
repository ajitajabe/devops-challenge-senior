FROM python:3.12-slim

# Create non-root user
RUN useradd -m appuser

# Set workdir and copy code
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .

# Set user
USER appuser

# Run app
CMD ["python", "app.py"]
