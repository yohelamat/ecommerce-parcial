import os
import datetime
from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/')
def home():
    fecha_actual = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    
    # Obtener host de la DB desde variables de entorno
    db_host = os.environ.get("DB_HOST", "localhost")
    
    return jsonify({
        "proyecto": "Startup E-commerce - Parcial (Versión Final)",
        "estudiante": "Yohel Amat",
        "fecha": fecha_actual,
        "estado_bd": f"Conectado a DB en {db_host}",
        "catalogo": [
            {"id": 1, "producto": "Pase Ecoturístico", "precio": 25.00},
            {"id": 2, "producto": "Kit de Senderismo", "precio": 45.00}
        ]
    })

if __name__ == '__main__':
    puerto = int(os.environ.get('PORT', 8080))
    app.run(host='0.0.0.0', port=puerto)