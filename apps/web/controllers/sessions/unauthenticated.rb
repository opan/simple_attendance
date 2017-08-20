module Web::Controllers::Sessions
  class Unauthenticated
    include Web::Action

    def call(params)
      session[:return_to] = warden('options')[:attempted_path] if session[:return_to].nil?

      flash[:alert] = warden.message || 'You must login to continue'
      redirect_to routes.new_session_path
    end

    private

    # Skip CSRF protection
    def verify_csrf_token?
      false
    end
  end
end
