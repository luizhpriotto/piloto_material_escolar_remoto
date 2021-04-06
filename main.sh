#!/bin/sh
set -ex
python manage.py migrate
python manage.py collectstatic --noinput
gunicorn config.wsgi:application --reload --bind=0.0.0.0:8001 -w 8

