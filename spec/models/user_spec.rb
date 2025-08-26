require 'rails_helper'

RSpec.describe User, type: :model do
 describe '#full_name' do
  it 'returns "First Last" for a user with both names' do
    user = User.create!(first_name: 'Mechelle', last_name: 'Presnell', email: 'me@example.com')
    expect(user.full_name).to eq('Mechelle Presnell')
  end

  it 'returns just the first name when the last name is missing' do
    user = User.create!(first_name: 'Mechelle', email: 'mechelle2@example.com')
    expect(user.full_name).to eq('Mechelle')
  end
 end
end
