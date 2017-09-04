# frozen_string_literal: true

require_relative '../../../../apps/web/controllers/sessions/create'

RSpec.describe Web::Controllers::Sessions::Create, type: :action do
  let(:action) { described_class.new }
  let(:valid_params) {{
    user: {
      username: 'foo',
      password: 'test1234'
    }
  }}

  let(:invalid_params) {{}}

  context 'with valid params' do
    it 'is successful' do
      sign_in(action: action)
      response = action.call(valid_params)
      expect(action.params.valid?).to be_truthy
      expect(action.exposures[:flash][:info]).to eq "You've successfully logged in"
      expect(response[1]['Location']).to eq '/dashboards'
    end
  end

  context 'with invalid params' do
    it 'is failed' do
      expect do
        sign_in(action: action, user: nil)
        action.call(invalid_params)
      end.to throw_symbol(:warden)
    end
  end
end
