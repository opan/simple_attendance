# frozen_string_literal: true

require_relative '../../../../apps/web/controllers/dashboards/index'

RSpec.describe Web::Controllers::Dashboards::Index, type: :request do
  let(:params) { {} }

  context 'without sign in' do
    it 'will failed and redirected to sign in page' do
      get '/dashboards'
      expect(last_response.get_header('Location')).to eq '/sessions/new'
      expect(last_request.env['AUTH_VALID']).to be_falsey
    end
  end

  context 'after sign in' do
    it 'success accessing dashboard page' do
      user = UserRepository.new.create_with_password(username: 'user', email: 'user@email.com', password: '1234')
      login_as user
      get '/dashboards'
      expect(last_response.ok?).to be_truthy
      expect(last_request.env['AUTH_VALID']).to be_truthy
    end
  end
end
