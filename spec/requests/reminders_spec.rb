require "rails_helper"

RSpec.describe "Reminders", type: :request do    
  # let!(:user) { create(:user) }
  #   let!(:reminder) { create(:reminder, :user user) }
  let!(:user) do 
    User.create!(
      first_name: "A", 
      last_name: "B", 
      email: "a@b.com",
      password: "password123",
      password_confirmation: "password123"
      )
    end


  it "creates a reminder" do
      expect {
        post user_reminders_path(user), params: { reminder: { message: "Weigh-in", frequency: "Daily", time_of_day: "08:00" } }
    }.to change { Reminder.count }.by(1)
    expect(response).to redirect_to(dashboard_path)
    follow_redirect!

    expect(response.body).to include("Weigh-in")
    expect(response.body).to include("Daily")
    expect(response.body).to include("08:00")
  end

  it "updates a reminder" do
    r = user.reminders.create!(message: "Water", frequency: "hourly", time_of_day: "10:00")
    # expect(r.user_id).to eq(user.id)

    patch user_reminder_path(user, r), params: { reminder: { message: "Hydrate" } }

    expect(response).to redirect_to(dashboard_path)
    follow_redirect!
    expect(response.body).to include("Hydrate")
    expect(r.reload.message).to eq("Hydrate")
  end
end
