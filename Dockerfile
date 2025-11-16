
FROM osgeo/gdal:ubuntu-small-3.6.2

# Install Python
RUN apt-get update && apt-get install -y python3 python3-pip
RUN apt-get update && apt-get install -y tzdata && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

COPY . .

RUN python3 manage.py collectstatic --noinput

CMD ["gunicorn", "shop_service.wsgi:application", "--bind", "0.0.0.0:8002"]
