# /routes/journal.py
from flask import Blueprint, request, jsonify

journal_bp = Blueprint('journal', __name__)


@journal_bp.route('/api/journal', methods=['POST'])
def submit_journal():
    data = request.get_json()
    journal_entry = data.get('entry')
    if not journal_entry:
        return jsonify({"error": "Journal entry is required!"}), 400
    # Save journal logic here
    return jsonify({"message": "Journal entry saved successfully!"}), 201
