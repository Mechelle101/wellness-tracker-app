require 'rails_helper'

RSpec.describe "Dashboard", type: :request do
    it "returns the dashboard page" do
 
      user = User.create!(
        first_name: "Test", 
        last_name: "User", 
        email: "test@test.com", 
        password: "password123",
        password_confirmation: "password123"
        )
      entry = Entry.create!(user: user, date: Date.current, notes: "Hi")
      NutritionLog.create!(
        user: user, entry: entry, 
        meal_type: "Breakfast", food_type: "Shake", 
        calories: 600, protein_g: 50, carbs_g: 95, fats_g: 3
        )

      get "/dashboard"

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Dashboard")
      expect(response.body).to include(entry.date.to_s)
      expect(response.body).to include("Calories")
    end
end
