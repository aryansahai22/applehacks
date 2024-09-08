# /routes/__init__.py
from .photo import photo_bp
from .journal import journal_bp
from .wellbeing import wellbeing_bp
from .recommendations import recommendations_bp
from .auth import auth_bp  

def init_app(app):
    app.register_blueprint(photo_bp)
    app.register_blueprint(journal_bp)
    app.register_blueprint(wellbeing_bp)
    app.register_blueprint(recommendations_bp)
    app.register_blueprint(auth_bp)  