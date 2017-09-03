# frozen_string_literal: true

require_relative '../../../../apps/web/controllers/dashboards/index'

RSpec.describe Web::Controllers::Dashboards::Index, type: :action do

  let(:action) { described_class.new }
  let(:params) { {} }
  # let(:warden) { double('Warden') }
  # let(:user) { double('User')}

  context 'without sign in' do
    it 'will failed and redirected to sign in page' do
      # allow(warden).to receive(:authenticate!)
      # allow(warden).to receive(:user) { nil }
      # allow(warden).to receive(:authenticated?) { false }
      # allow(action.send(:request)).to receive(:env).and_return({ 'warden' => warden })
      # response = action.call(params)
      # binding.pry
      get '/dashboards'
      expect(last_response.get_header('Location')).to eq '/sessions/new'
    end
  end

  context 'after sign in' do
    it 'success accessing dashboard page' do
      user = UserRepository.new.create_with_password(username: 'user', email: 'user@email.com', password: '1234')
      login_as user
      get '/dashboards'
      expect(last_response.ok?).to be_truthy
    end
  end
end
