require "rails_helper"

RSpec.describe "Supplements", type: :request do
  let!(:user) { User.create!(first_name: "A", last_name: "B", email: "sup@example.com", password: "secret123") }
  before { sign_in_as(user) }

  it "creates and prevents exact duplicate name for same user" do
    post "/users/#{user.id}/supplements", params: { supplement: { name: "Creatine", dosage: "5g", frequency: "daily" } }
    expect(response).to redirect_to("/dashboard")
    post "/users/#{user.id}/supplements", params: { supplement: { name: "creatine" } }
    expect(response.status).to eq(422)
  end
end