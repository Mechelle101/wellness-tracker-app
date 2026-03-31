require "rails_helper"

RSpec.describe Supplement, type: :model do
  let(:user) { User.create!(first_name: "A", last_name: "B", email: "a@example.com", password: "secret123")}

  it "requires name and user" do
    s = Supplement.new(user: user, name: "")
    expect(s).not_to be_valid
    expect(s.errors[:name]).to be_present
  end

  it "normalizes and enforces scoped uniqueness case-insensitively" do
    Supplement.create!(user: user, name: "  Creatine  ")
    dup = Supplement.new(user: user, name: "creatine")
    expect(dup).not_to be_valid
    expect(dup.errors[:name]).to include(/taken/i)
  end

end
