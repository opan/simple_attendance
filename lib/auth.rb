# require 'rack-flash'

module Auth
  module Helpers
    # The main accessor to the warden middleware
    def warden(scope = nil)
      scope ? request.env["warden.#{scope}"] : request.env['warden']
    end

    # Return session info
    #
    # @params [Symbol] the scope to retreive session info for
    def session_info(scope = nil)
      scope ? warden.session(scope) : scope
    end

    # Check the current session is authenticated to a given scope
    def authenticated?(scope = nil)
      scope ? warden.authenticated?(scope: scope) : warden.authenticated?
    end
    alias_method :logged_in?, :authenticated?

    # Authenticate a user against defined strategies
    def authenticate(*args)
      warden.authenticate!(*args)
    end
    alias_method :login, :authenticate

    # Terminate the current session
    #
    # @param [Symbol] the session scope to terminate
    def logout(scopes = nil)
      scopes ? warden.logout(scopes) : warden.logout(warden.config.default_scope)
    end

    def current_user(scope = nil)
      scope ? warden.user(scope) : warden.user
    end
  end
end

module Auth
  def self.included(app)
    app.include Helpers
    app.class_eval do
      expose :current_user, :logged_in?
    end

    app.use Warden::Manager do |config|
      config.failure_app = Web::Controllers::Sessions::Unauthenticated
      config.default_strategies :password
      config.default_scope = :user
      config.scope_defaults :user,
        strategies: [:password],
        store: true,
        action: 'sessions/unauthenticated'
    end

    Warden::Manager.serialize_into_session do |resource|
      # Object that suppose to keep in the session
      resource.id
    end

    Warden::Manager.serialize_from_session do |resource_id|
      UserRepository.new.find(resource_id)
    end

    # Warden callbacks executed every time user is authenticated
    Warden::Manager.after_authentication do |user, auth, opts|
      # Update last_signed_in
      UserRepository.new.update(user.id, last_signed_in: Time.now)
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

        if username.nil? || password.nil?
          fail!('Username nor password cannot be empty')
        else
          resource = UserRepository.new.authenticate!(username, password)
          resource.nil? ? fail!('Username and password combination is invalid') : success!(resource)
        end
      end
    end
  end
end
