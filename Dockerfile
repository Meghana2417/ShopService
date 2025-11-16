
FROM python:3.10-slim

# Install GDAL
RUN apt-get update && apt-get install -y \
    gdal-bin \
    libgdal-dev \
    && rm -rf /var/lib/apt/lists/*

# GDAL correct path
ENV GDAL_LIBRARY_PATH=/usr/lib/libgdal.so.32

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Do NOT run collectstatic here

EXPOSE 8002

CMD ["gunicorn", "shop_service.wsgi:application", "--bind", "0.0.0.0:8002"]
