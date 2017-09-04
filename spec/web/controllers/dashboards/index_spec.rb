# frozen_string_literal: true

require_relative '../../../../apps/web/controllers/dashboards/index'

RSpec.describe Web::Controllers::Dashboards::Index, type: :action do
  let(:action) { described_class.new }
  let(:params) { {} }

  it 'is success' do
    sign_in(action: action)
    response = action.call(params)
    expect(response[0]).to eq 200
  end
end
