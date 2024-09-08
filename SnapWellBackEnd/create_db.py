from app import app, db
from models.user import User
from models.journal_entry import JournalEntry
from models.recommendations import Recommendation
from models.wellbeing_rating import WellbeingRating


def create_db():
    with app.app_context():
        db.create_all()  # Creates all tables defined by the models
        print("Database tables created successfully.")


if __name__ == '__main__':
    create_db()
