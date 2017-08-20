module Web::Controllers::Registrations
  class Create
    include Web::Action

    params do
      required(:user).schema do
        required(:username).filled(:str?)
        required(:email).filled(:str?)
        required(:password).filled(:str?).confirmation
      end
    end

    def call(params)
      user = UserRepository.new.create_with_password(params.get(:user))

      if user.nil?
        render :new
      else
        params.env['warden'].authenticate!
        redirect_to routes.dashboards_path
      end
    end
  end
end
