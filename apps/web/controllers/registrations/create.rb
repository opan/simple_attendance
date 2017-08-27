# frozen_string_literal: true

module Web::Controllers::Registrations
  class Create
    include Web::Action

    # handle_exception Hanami::Model::Error => :handle_unique_constraint
    params do
      required(:user).schema do
        required(:username).filled(:str?)
        required(:email).filled(:str?)
        required(:password).filled(:str?).confirmation
      end
    end

    def call(params)
      validate_uniqueness_email_username!

      if params.valid?
        if validate_uniqueness_email_username!
          UserRepository.new.create_with_password(params.get(:user))
          authenticate
          flash[:info] = "You've successfully signed up and automatically logged in!"
          redirect_to session[:return_to] || routes.dashboards_path
        else
          flash[:alert] = "Email or Username has already been taken. Please try another one."
          self.status = 422
        end
      else
        flash[:alert] = %{
          Something went wrong while signing up!\t
          Please check error list below:\n\n
          #{params.error_messages.join("\n</br>")}
        }
        self.status = 422
      end
    end

    private

      def validate_uniqueness_email_username!
        email = params.get(:user, :email)
        username = params.get(:user, :username)
        validating = UserRepository.new.query(Sequel.or(username: username, email: email)).count
        validating.zero?
      end
  end
end
