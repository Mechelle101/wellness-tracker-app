require "rails_helper"

RSpec.describe "Reminders", type: :request do    
  let!(:user) { User.create!(first_name: "A", last_name: "B", email: "rem@example.com", password: "secret123") }
  before { sign_in_as(user) } 

  it "creates a reminder" do
    expect {
      post user_reminders_path(user), params: { reminder: { message: "Weigh-in" } }
    }.to change { Reminder.count }.by(1)
    expect(response).to redirect_to(dashboard_path)
  end

  it "updates a reminder" do
    r = Reminder.create!(user: user, message: "Hydrate")
    patch user_reminder_path(user, r), params: { reminder: { message: "Hydrate now" } }
    expect(response).to redirect_to(dashboard_path)
    expect(r.reload.message).to eq("Hydrate now")
  end

end
