module Auth
  def self.included(app)
    app.use Warden::Manager do |config|
      config.failure_app = Web::Controllers::Sessions::New
      config.default_strategies :password
      config.default_scope = :user
      config.scope_defaults :user,
        strategies: [:password],
        store: false,
        action: 'sessions/new'
    end

    Warden::Manager.serialize_into_session do |resource|
      # Object that suppose to keep in the session
      resource.id
    end

    Warden::Manager.serialize_from_session do |resource_id|
      UserRepository.find(resource_id)
    end

    # Warden callbacks executed every time user is authenticated
    Warden::Manager.after_authentication do |user, auth, opts|
    end

    # Warden callbacks run right before the failure application is called
    Warden::Manager.before_failure do |env, opts|
      env['REQUEST_METHOD'] = 'POST'
    end

    # Warden callbacks run before each user is logged out
    Warden::Manager.before_logout do |user, auth, opts|
    end

    Warden::Strategies.add(:password) do
      def valid?
        params['user'] && params['user']['username'] && params['user']['password']
      end

      def authenticate!
        username = params['user']['username']
        password = params['user']['password']

        if params['user']['username'].nil?
          throw(:warden, message: 'The username you entered does not exists')
        else
          user = UserRepository.new.authenticate!(username, password)
          user.nil? ? throw(:warden, message: 'Username and password combination is invalid') : success!(user)
        end
      end
    end
  end
end
