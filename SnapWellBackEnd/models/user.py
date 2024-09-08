from flask_sqlalchemy import SQLAlchemy
from werkzeug.security import generate_password_hash, check_password_hash
from flask_login import UserMixin
from app import db

class User(db.Model, UserMixin):
    __tablename__ = 'users'

    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(50), nullable=False, unique=True)
    email = db.Column(db.String(120), nullable=False, unique=True)
    password = db.Column(db.String(255), nullable=False)

    # Relationships
    journal_entries = db.relationship(
        'JournalEntry', back_populates='user', cascade='all, delete-orphan')
    wellbeing_ratings = db.relationship(
        'WellbeingRating', back_populates='user', cascade='all, delete-orphan')
    recommendations = db.relationship('Recommendation', back_populates='user')

    def __repr__(self):
        return f"<User(id={self.id}, username='{self.username}', email='{self.email}')>"

    def set_password(self, password):
        self.password = generate_password_hash(password)

    def check_password(self, password):
        return check_password_hash(self.password, password)
