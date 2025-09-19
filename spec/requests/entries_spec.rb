require 'rails_helper'

RSpec.describe "Entries", type: :request do
  let!(:user) { User.create!(first_name: "Test", last_name: "User", email: "test@test.com", password_digest: "x")}

  it "lists entries" do
    Entry.create!(user: user, date: Date.current, notes: "Today")
    get "/entries"
    expect(response).to have_http_status(:ok)
    expect(response.body).to include("Your Entries")
  end

  it "shows a single entry with meals" do
    entry = Entry.create!(user: user, date: Date.current, notes: "Notes")
    NutritionLog.create!(user: user, entry: entry, meal_type: "Breakfast", food_type: "Shake", calories: 600, protein_g: 50, carbs_g: 95, fats_g: 3)

    get "/entries/#{entry.id}"
    expect(response).to have_http_status(:ok)
    expect(response.body).to include(entry.date.to_s)
    expect(response.body).to include("Meals")
    expect(response.body).to include("Shake")
  end
end
