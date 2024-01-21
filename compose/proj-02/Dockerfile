FROM python:3.7-alpine
	# First build a Python 3.7 image. 
	# It will be pulled from Docker Hub 
	# if not locally present

WORKDIR /code
	# Set our working directory to 
	# /code inside the container.

ENV FLASK_APP application.py
ENV FLASK_RUN_HOST 0.0.0.0
	# Set environment variables, 
	# needed by the flask command

RUN apk add --no-cache gcc musl-dev linux-headers
	# Install gcc compiler and other 
	# dependencies

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
	# Copy requirements.txt into our 
	# working directory here /code to be 
	# used in installation of the Python 
	# pip dependencies
EXPOSE 5000
	# Expose the port 5000 on which 
	# the container is listening to
COPY . .
	# Copy the content of current directory . 
	# into the project to the workdir . 
	# in the image that is being built
CMD ["flask", "run"]
	# Set the container to run flask.
