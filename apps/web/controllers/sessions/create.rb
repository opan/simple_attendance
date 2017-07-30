module Web::Controllers::Sessions
  class Create
    include Web::Action

    params do
      required(:session).schema do
        required(:username).filled(:str?)
        required(:password).filled(:str?)
      end
    end

    def call(params)
      redirect_to routes.new_session_path
    end
  end
end
