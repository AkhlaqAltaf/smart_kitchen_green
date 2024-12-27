
celery -A core worker --loglevel=info --pool=solo

celery -A core beat --loglevel=info

