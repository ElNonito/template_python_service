FROM python:latest

ADD requirements.txt /home/requirements.txt

# Redirect http://127.0.0.1:8000 to this container
EXPOSE 8000

# Install dependencies
RUN pip install -r /home/requirements.txt
# add core and api 
ADD core /home/core
ADD api /home/api
WORKDIR /home/api
# Modifier la ligne suivante pour lancer le serveur
ENTRYPOINT bash
