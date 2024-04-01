#!/bin/sh
gunicorn hello_django.wsgi:application --bind 10.0.0.10:8000
