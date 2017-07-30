module Web::Controllers::Registrations
  class Create
    include Web::Action

    params do
      required(:registration).schema do
        required(:username).filled(:str?)
        required(:email).filled(:str?)
        required(:password).filled(:str?).confirmation
      end
    end

    def call(params)
      debugger
      redirect_to routes.new_registration_path
    end
  end
end
