# /routes/recommendations.py
from flask import Blueprint, request, jsonify
import openai
import os
from dotenv import load_dotenv
from services.recommendation_service import generate_recommendations_based_on_wellbeing

# Initialize Blueprint
recommendations_bp = Blueprint('recommendations', __name__)

# OpenAI API Key
load_dotenv()
openai.api_key = os.getenv('OPENAI_API_KEY')


@recommendations_bp.route('/api/recommendations', methods=['GET'])
def get_recommendations():
    user_id = request.args.get('user_id')

    if not user_id:
        return jsonify({"error": "User ID is required!"}), 400

    # Call the service to get recommendations based on user's well-being
    try:
        recommendations = generate_recommendations_based_on_wellbeing(user_id)
        return jsonify({"recommendations": recommendations}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500
