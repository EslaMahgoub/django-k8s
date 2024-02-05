#!/bin/bash

APP_PORT=${PORT:-8000}

cd /app/

# Run gunicorn
/opt/venv/bin/gunicorn --worker-tmp-dir /dev/shm django_k8s.wsgi:application --bind "0.0.0.0:${APP_PORT}"

# Run migrations
/opt/venv/bin/python manage.py migrate

# Create admin user
/opt/venv/bin/python manage.py create_admin_user

# Load fixtures
/opt/venv/bin/python manage.py loaddata products/fixtures/*
