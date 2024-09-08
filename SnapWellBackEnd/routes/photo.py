# /routes/photo.py
from flask import Blueprint, request, jsonify

photo_bp = Blueprint('photo', __name__)


@photo_bp.route('/api/photo', methods=['POST'])
def upload_photo():
    if 'photo' not in request.files:
        return jsonify({"error": "No photo uploaded!"}), 400
    photo = request.files['photo']
    # Save photo logic here
    return jsonify({"message": "Photo uploaded successfully!"}), 201
