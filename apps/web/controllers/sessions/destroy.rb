module Web::Controllers::Sessions
  class Destroy
    include Web::Action

    def call(params)
      authenticate
      logout
      flash[:info] = "You've been successfully logged out"
      redirect_to routes.new_session_path
    end
  end
end
