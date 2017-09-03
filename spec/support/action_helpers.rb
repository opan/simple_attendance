module ActionHelpers
  def sign_in(action:, user: double('User'))
    # config = Warden::Config.new
    # config.failure_app = Web::Controllers::Sessions::Unauthenticated
    # config.default_strategies :password
    # config.default_scope = :user
    # config.scope_defaults :user, strategies: [:password], store: true, action: 'sessions/unauthenticated'
    # # config.merge!({
      # default_strategies: :password,
    # })
    # config = Warden::Config.new({
      # default_scope: :user,
      # scope_defaults: {
        # user: {
          # store: true, action: 'sessions/unauthenticated',
          # strategies: [:password],
        # },
      # },
      # default_strategies: [:password],
    # })

    # Warden::Manager.before_failure do |env, opts|
      # binding.pry
      # # env['REQUEST_METHOD'] = 'POST'
      # # env['AUTH_VALID'] = false
    # end

    # Warden::Strategies.add(:password) do
      # def valid?
        # false
      # end

      # def authenticate!
        # fail!('Failed test')
      # end
    # end

    # warden = Warden::Proxy.new({}, Warden::Manager.new(Hanami.app, config))
    # binding.pry
    warden = double('Warden')
    allow(action.send(:request)).to receive(:env).and_return({ 'warden' => warden })
    allow(warden).to receive(:user) { user }

    if user.nil?
      allow(warden).to receive(:authenticate!).and_throw(:warden)
      allow(warden).to receive(:authenticated?) { false }
    else
      allow(warden).to receive(:authenticate!).and_throw(:warden)
      allow(warden).to receive(:authenticated?) { true }
    end
  end
end
