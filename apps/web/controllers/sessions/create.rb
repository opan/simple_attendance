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
      # username = params.get(:user, :username)
      # password = params.get(:user, :password)
      # user = UserRepository.new.authenticate!(username, password)

      authenticate
      redirect_to session[:return_to] || routes.dashboards_path
      # if user.nil?
        # # redirect_to routes.new_session_path
        # render :new
      # else
        # flash[:info] = 'Welcome back!'
        # redirect_to routes.dashboards_path
      # end
    end
  end
end
