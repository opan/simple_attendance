# frozen_string_literal: true

require_relative '../../../../apps/web/controllers/sessions/new'

describe Web::Controllers::Sessions::New, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  context 'when signed in' do
    it 'redirect to dashboards' do
      sign_in(action: action)
      response = action.call(params)
      expect(response[1]['Location']).to eq '/dashboards'
    end
  end

  context 'when not signed in' do
    it 'get expected response' do
      sign_in(action: action, user: nil)
      response = action.call(params)
      expect(response[0]).to eq 200
    end
  end
end
