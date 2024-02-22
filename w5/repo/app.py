from flask import Flask
from redis import Redis
 
app = Flask(__name__)
redis = Redis(host='127.0.0.1', port=6379)
@app.route('/')
def helloii():
    return "Hello World"
@app.route('/hit')
def hello():
    redis.incr('hits')
    counter = str(redis.get('hits'),'utf-8')
    return "This webpage has been viewed "+counter+" time(s)"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000, debug=True)
