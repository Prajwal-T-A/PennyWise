from flask import Flask, request, jsonify
from epf import calculate_epf_projection  # Import your EPF calculation function

app = Flask(__name__)

@app.route('/calculate_epf', methods=['POST'])
def calculate_epf():
    try:
        # Parse JSON data from request
        data = request.json
        income = float(data['income'])
        years = int(data['years'])
        rate = float(data['rate'])

        # Calculate EPF projection
        epf, no_epf = calculate_epf_projection(income, years, rate)

        # Return result as JSON
        return jsonify({'withEPF': epf, 'withoutEPF': no_epf})
    except Exception as e:
        return jsonify({'error': str(e)})

if __name__ == '__main__':
    app.run(debug=True)
