# from flask import Flask
# app = Flask(__name__) 
  
# @app.route("/")
# def home():
#     return "Hello, Flask!"

import pickle
from flask import Flask, jsonify, request, render_template
import tensorflow as tf
keras = tf.keras
models = tf.keras.models

from bail_predict import preprocess, vectorizer
#from sklearn.feature_extraction.text import TfidfVectorizer
# Use the imported functions in your Flask application

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/prediction/<user_input>', methods=['GET'])
def prediction(user_input):

    #user_input = request.form['user_input']

    preprocessed_input = preprocess(user_input)
    #vectorizer = TfidfVectorizer(ngram_range=(1,2), max_features=500000)

    vectorized_input = vectorizer.transform([preprocessed_input])

    stacking_model = models.load_model("stacking_model.model")

    proba = stacking_model.predict(vectorized_input)
    confidence_score = proba[0, 1]  # Probability for class 1 (Bail Granted)

    return  jsonify({'Confidence' : f'{confidence_score:.4f}'})

if __name__ == '_main_':
    app.run()