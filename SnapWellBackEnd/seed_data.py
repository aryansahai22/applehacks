from app import app, db
from models.user import User
from models.journal_entry import JournalEntry
from models.recommendations import Recommendation
from models.wellbeing_rating import WellbeingRating
from sqlalchemy import inspect


def seed():
    with app.app_context():
        # Check if tables exist
        inspector = inspect(db.engine)
        if 'users' in inspector.get_table_names():  # Check for 'users' table instead of 'user'
            # Add your seed data here
            user1 = User(username='john_doe', email='john@example.com')
            user1.set_password('securepassword')
            db.session.add(user1)
            db.session.commit()
            print("Seed data added.")
        else:
            print("Table 'users' does not exist. Please run create_db.py first.")


if __name__ == '__main__':
    seed()
