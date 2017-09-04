# frozen_string_literal: true

module ActionHelpers
  # `warden` and `env` is come from Warden::Test::Mock
  def sign_in(action:, user: User.new)
    allow(action.send(:request)).to receive(:env) { env }
    warden.set_user(user) unless user.nil?
  end
end
