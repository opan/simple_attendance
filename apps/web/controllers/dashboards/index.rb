module Web::Controllers::Dashboards
  class Index
    include Web::Action

    def call(params)
      debugger
      authenticate
    end
  end
end
