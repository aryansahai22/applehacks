from routes import init_app
from models.wellbeing_rating import WellbeingRating
from models.recommendations import Recommendation
from models.journal_entry import JournalEntry
from models.user import User
from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_login import LoginManager
import os

db = SQLAlchemy()
login_manager = LoginManager()

app = Flask(__name__)
app.config.from_object('config.Config')

# Initialize extensions
db.init_app(app)
login_manager.init_app(app)
login_manager.login_view = 'auth.login'


@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))


# Initialize routes
init_app(app)

if __name__ == '__main__':
    app.run(debug=True)
