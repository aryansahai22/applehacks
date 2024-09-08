# /routes/dashboard.py
from flask import Blueprint, render_template
from flask_login import login_required, current_user
from models.journal_entry import JournalEntry
from models.wellbeing_rating import WellbeingRating
from models.recommendations import Recommendation
from app import db  # Assuming you are using SQLAlchemy

dashboard_bp = Blueprint('dashboard', __name__)


@dashboard_bp.route('/dashboard')
@login_required
def dashboard():
    # Fetch the user's recent photo prompts, journal entries, and well-being ratings
    user_id = current_user.id

    # Fetch recent journal entries
    journal_entries = db.session.query(JournalEntry).filter_by(
        user_id=user_id).order_by(JournalEntry.timestamp.desc()).limit(5).all()

    # Fetch recent well-being ratings
    wellbeing_ratings = db.session.query(WellbeingRating).filter_by(
        user_id=user_id).order_by(WellbeingRating.date.desc()).limit(5).all()

    # Fetch recent personalized recommendations
    recommendations = db.session.query(Recommendation).filter_by(
        user_id=user_id).order_by(Recommendation.date.desc()).limit(5).all()

    # render template with user data
    return render_template(
        'dashboard.html',
        journal_entries=journal_entries,
        wellbeing_ratings=wellbeing_ratings,
        recommendations=recommendations
    )
