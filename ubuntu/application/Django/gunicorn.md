## gunicorn_start
```bash
NAME="mysite"							# Nama dari sebuah projeck
DJANGODIR=/path/mysite					# Direktory projeck Django
SOCKFILE=127.0.0.1:8000					# Penghubung untuk unix socket projek
USER=sava									# Pengguna menjalan sebagai
GROUP=Django									# Grup menjalan sebagai
NUM_WORKERS=1							# Proses bekerja di Gunicorn
DJANGO_SETTINGS_MODULE=mysite.settings 	# Pengaturan pada projek Django
DJANGO_WSGI_MODULE=mysite.wsgi 			# Nama modul WSGI Django

echo "Start $NAME as 'whoami'"
cd $DJANGODIR
source /venv/bin/activate
export DJANGO_SETTINGS_MODULE=$DJANGO_SETTINGS_MODULE
export PYTHONPATH=$DJANGODIR:$PYTHONPATH

exec /venv/bin/gunicorn $(DJANGO_WSGI_MODULE):application \
	--name $NAME \
	--workers $NUM_WORKERS \
	--user=$USER --group=$GROUP \
	--bind=$SOCKFILE \
	--log-level=debug \
	--log-file=-
```