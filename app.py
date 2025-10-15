from flask import Flask 
from flask import render_template 
import mysql.connector as connection 

app = Flask (__name__)

@app.route ("/um")
def um():
    return render_template ("um.html")

@app.route ("/dois")
def dois():
    return render_template ("dois.html")

@app.route ("/tres")
def tres():
    return render_template ("tres.html")

@app.route ("/quatro")
def quatro():
    return render_template ("quatro.html")

@app.route ("/cinco")
def cinco():
    return render_template ("cinco.html")

@app.route ("/seis")
def seis():
    return render_template ("seis.html")

@app.route ("/sete")
def sete():
    return render_template ("sete.html")

@app.route ("/oito")
def oito(): 
    return render_template ("oito.html")

