module Web::Controllers::Dashboards
  class Index
    include Web::Action

    def call(params)
      params.env['warden'].authenticate!(:password)
      debugger
    end
  end
end
