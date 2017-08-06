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
      user_params = params.get(:user)
      enc_password = BCrypt::Password.create(user_params[:password])
      user = UserRepository.new.create(
        username: user_params[:username],
        email: user_params[:email],
        encrypted_password: enc_password,
        last_signed_in: Time.now.utc
      )
      debugger

      if user.nil?
        redirect_to routes.new_registration_path
      else
        params.env['warden'].authenticate!(:password)
        flash[:info] = 'You have successfully registered'
        redirect_to routes.dashboards_path
      end
    end
  end
end
