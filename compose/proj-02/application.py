import time
    # Import python time module to handle 
    # time related tasks like the function
    # time.sleep() below
import redis
    # Redis is, a popular, multi-model NoSQL 
    # database server, enables search, messaging, 
    #streaming, and other capabilities.

from flask import Flask
    # Imported the Flask class. An instance 
    # of this class will be our Web Server 
    # Gateway Interface application

app = Flask(__name__)
    # Creates the Flask instance.
    # __name__ is the name of the current 
    # Python module. The app needs to know 
    # where it’s located to set up some paths, 
    # and __name__ is a convenient way to tell it that.

cache = redis.Redis(host='redis', port=6379)
    # Creates a connection to Redis, where
    # host: is the your database IP or name
    # port: the database connection port


def get_hit_count():
    # Defnines a get_git_count() function here
    # to be called later see the bottom of this
    # python program
    retries = 5
    while True:
        try:
            return cache.incr('hits')
            # returns to the caller of this function
            # the number of hits on the database host:port
            # mentioned above
        except redis.exceptions.ConnectionError as exc:
            if retries == 0:
                raise exc
            retries -= 1
            time.sleep(0.5)
            # sleep for 0.5 to delay the actions


@app.route('/')
    # We then use the route() decorator 
    # to tell Flask what URL should trigger 
    # our function
def hello():
    count = get_hit_count()
    return 'Hello World ! I have been seen {} times.\n'.format(count)
