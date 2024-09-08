# /routes/wellbeing.py
from flask import Blueprint, request, jsonify

# Initialize Blueprint
wellbeing_bp = Blueprint('wellbeing', __name__)


@wellbeing_bp.route('/api/wellbeing', methods=['POST'])
def submit_wellbeing():
    data = request.get_json()
    rating = data.get('rating')

    if rating is None:
        return jsonify({"error": "Rating is required!"}), 400

    if not (1 <= rating <= 10):
        return jsonify({"error": "Rating must be between 1 and 10!"}), 400

    # Save the rating logic here (e.g., to a database)

    return jsonify({"message": "Rating saved successfully!"}), 201
