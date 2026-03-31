module AuthHelpers
  def sign_in_as(user)
    allow_any_instance_of(ApplicationController)
    .to receive(:current_user).and_return(user)
  end
end

RSpec.configure do |config|
  config.include AuthHelpers, type: :request
  config.include AuthHelpers, type: :controller
end
