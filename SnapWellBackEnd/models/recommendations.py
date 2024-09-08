from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship
from app import db


class Recommendation(db.Model):
    __tablename__ = 'recommendations'

    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=False)
    suggestion = db.Column(db.String(255), nullable=False)

    # Relationships
    user = db.relationship('User', back_populates='recommendations')

    def __repr__(self):
        return f"<Recommendation(id={self.id}, user_id={self.user_id}, suggestion='{self.suggestion}')>"
