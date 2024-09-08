from sqlalchemy import Column, Integer, ForeignKey, DateTime
from sqlalchemy.orm import relationship
import datetime
from app import db


class WellbeingRating(db.Model):
    __tablename__ = 'wellbeing_ratings'

    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=False)
    rating = db.Column(db.Integer, nullable=False)
    created_at = db.Column(db.DateTime, default=datetime.datetime.utcnow)

    # Relationships
    user = db.relationship('User', back_populates='wellbeing_ratings')

    def __repr__(self):
        return f"<WellbeingRating(id={self.id}, user_id={self.user_id}, rating={self.rating}, created_at={self.created_at})>"
