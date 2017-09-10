# frozen_string_literal: true

module Web::Controllers::Registrations
  class New
    include Web::Action

    def call(params)
      if authenticated?
        flash[:warning] = "You've already signed in!"
        redirect_to routes.dashboards_path
      end
    end
  end
end
