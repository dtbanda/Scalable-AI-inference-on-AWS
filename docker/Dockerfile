# Lightweight Python Image
FROM python:3.10-slim

# Set environment variables to reduce Python output noise
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy your application code in the container
COPY ./api /app

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port for app 
EXPOSE 8000

# Run app 
# 6. Start the FastAPI app using uvicorn
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000", "--worker", "1", "timeout-keep-alive", "5"]
