require "rails_helper"

RSpec.describe Entry, type: :model do
  let(:user) { User.create!(first_name: "A", last_name: "B", email: "c@example.com", password: "secret123") }


  it "requires date and user and enforces one-per-day per user" do
    Entry.create!(user: user, date: Date.current)
    dup = Entry.new(user: user, date: Date.current)
    expect(dup).not_to be_valid
    expect(dup.errors[:date]).to be_present
  end
  
end
