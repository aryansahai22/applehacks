import openai
from models.recommendations import Recommendation
from models.wellbeing_rating import WellbeingRating
from app import db
from dotenv import load_dotenv
import os

# Load environment variables from .env file
load_dotenv()
openai.api_key = os.getenv('OPENAI_API_KEY')


def generate_recommendations_based_on_wellbeing(user_id):
    # Fetch user well-being data from the database
    wellbeing_data = get_wellbeing_data(user_id)

    if not wellbeing_data:
        raise ValueError("No well-being data found for user.")

    rating = wellbeing_data['rating']

    # Generate recommendations using OpenAI API
    try:
        response = openai.Completion.create(
            model="text-davinci-003",
            prompt=f"Based on a well-being rating of {
                rating}, provide some helpful relaxation techniques or activities.",
            max_tokens=150
        )
        return response.choices[0].text.strip()
    except Exception as e:
        # Handle potential exceptions from the OpenAI API call
        print(f"Error generating recommendation: {e}")
        return "Could not generate recommendation at this time."


def create_recommendation(user, suggestion):
    new_recommendation = Recommendation(user_id=user.id, suggestion=suggestion)
    db.session.add(new_recommendation)
    db.session.commit()


def get_wellbeing_data(user_id):
    try:
        wellbeing = WellbeingRating.query.filter_by(user_id=user_id).order_by(
            WellbeingRating.created_at.desc()).first()

        if wellbeing:
            return {"rating": wellbeing.rating}
        else:
            return None  # No well-being data found

    except Exception as e:
        print(f"Error fetching well-being data: {e}")
        return None
