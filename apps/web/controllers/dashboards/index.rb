module Web::Controllers::Dashboards
  class Index
    include Web::Action

    def call(params)
      authenticate
    end
  end
end
