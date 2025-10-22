require 'rails_helper'

RSpec.describe "NutritionLogs", type: :request do
  let!(:user)  { User.create!(first_name: "A", last_name: "B", email: "nl@example.com", password: "secret123") }
  let!(:entry) { Entry.create!(user: user, date: Date.current) }

  before { sign_in_as(user) }

 it "lists nutrition logs for an entry" do
   post "/entries/#{entry.id}/nutrition_logs",
      params: { nutrition_log: { meal_type: "Breakfast", food_type: "Eggs", calories: 300, protein_g: 20, carbs_g: 2, fats_g: 20 } }
    follow_redirect! if response.redirect?

   get "/entries/#{entry.id}"
    expect(response).to have_http_status(:ok)
    expect(response.body).to include("Breakfast").or include("Eggs")
 end
end
