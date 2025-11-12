FROM python:3.12-slim

# Install GDAL and dependencies
RUN apt-get update && apt-get install -y \
    gdal-bin libgdal-dev python3-gdal \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Set environment variables
ENV PYTHONUNBUFFERED=1

# Expose Django port
EXPOSE 8002

# Start the app
CMD ["gunicorn", "shop_service.wsgi:application", "--bind", "0.0.0.0:8002"]
