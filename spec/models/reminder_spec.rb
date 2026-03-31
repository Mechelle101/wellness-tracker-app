require "rails_helper"

RSpec.describe Reminder, type: :model do
  let(:user) { User.create!(first_name: "A", last_name: "B", email: "b@example.com", password: "secret123")}

  it "requires message" do
    r = Reminder.new(user: user, message: "")
    expect(r).not_to be_valid
    expect(r.errors[:message]).to be_present
  end

  it "can be completed and uncompleted via completed_at" do
    r = Reminder.create!(user: user, message: "Drink water")
    expect(r.completed_at).to be_nil
    r.update!(completed_at: Time.current)
    expect(r.completed_at).not_to be_nil
    r.update!(completed_at: nil)
    expect(r.completed_at).to be_nil
  end
end
