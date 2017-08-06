module Web::Controllers::Sessions
  class Create
    include Web::Action

    params do
      required(:user).schema do
        required(:username).filled(:str?)
        required(:password).filled(:str?)
      end
    end

    def call(params)
      username = params.get(:session, :username)
      password = params.get(:session, :password)
      user = UserRepository.new.authenticate!(username, password)

      if user.nil?
        redirect_to routes.new_session_path
      else
        redirect_to routes.dashboards_path
      end
    end
  end
end
