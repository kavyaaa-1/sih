# from flask import Flask
# app = Flask(__name__) 
  
# @app.route("/")
# def home():
#     return "Hello, Flask!"

from flask import Flask, request, render_template
# app.py


from prediction import preprocess, stacking_model, vectorizer

# Use the imported functions in your Flask application


app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/predict', methods=['POST'])
def predict():

    user_input = request.form['user_input']

    preprocessed_input = preprocess(user_input)

    vectorized_input = vectorizer.transform([preprocessed_input])

    proba = stacking_model.predict_proba(vectorized_input)
    confidence_score = proba[0, 1]  # Probability for class 1 (Bail Granted)

    return f' Confidence: {confidence_score:.4f}'

if __name__ == '_main_':
    app.run()