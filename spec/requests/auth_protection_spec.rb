require "rails_helper"

RSpec.describe "Auth protection", type: :request do
  let!(:user) { User.create!(first_name:"T", last_name:"U", email:"t@u.com", password:"secret123") }
  let!(:entry) { user.entries.create!(date: Date.current) }

  it "forbids dashboard when unauthenticated" do
    get dashboard_path
    expect(response).to have_http_status(:found)
    expect(response).to redirect_to(new_session_path)
  end

  it "forbids entries index when unauthenticated" do
    get entries_path
    expect(response).to have_http_status(:found)
    expect(response).to redirect_to(new_session_path)
  end

  it "forbids nutrition logs new when unauthenticated" do
    get new_entry_nutrition_log_path(entry) 
    expect(response).to have_http_status(:found)
    expect(response).to redirect_to(new_session_path)
  end

  it "forbids reminders create when unauthenticated" do
    post user_reminders_path(user), params: { reminder: { message: "Weigh-in" } }
    expect(response).to have_http_status(:found)
    expect(response).to redirect_to(new_session_path)
  end
end
