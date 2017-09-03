module ActionHelpers
  def sign_in(action:, user: double('User'))
    warden = double('Warden')
    allow(action.send(:request)).to receive(:env).and_return({ 'warden' => warden })
    allow(warden).to receive(:user) { user }

    if user.nil?
      allow(warden).to receive(:authenticate!).and_throw(:warden)
      allow(warden).to receive(:authenticated?) { false }
    else
      allow(warden).to receive(:authenticate!)
      allow(warden).to receive(:authenticated?) { true }
    end
  end
end
