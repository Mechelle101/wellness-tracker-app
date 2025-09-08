require 'rails_helper'

RSpec.describe "NutritionLogs", type: :request do
 it "lists nutrition logs for an entry" do
    user = User.create!(first_name: "Test", last_name: "User", email: "test@test.com", password_digest: "x")
    entry = Entry.create!(user: user, date: Date.current)
    NutritionLog.create!(user: user, entry: entry, meal_type: "Lunch", food_type: "Rice", calories: 500, protein_g: 10, carbs_g: 90, fats_g: 5)

    get "/entries/#{entry.id}/nutrition_logs"
    expect(response).to have_http_status(:ok)
    expect(response.body).to include("Nutrition - #{entry.date}")
    expect(response.body).to include("Rice")
 end
end
