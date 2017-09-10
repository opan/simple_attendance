# frozen_string_literal: true

require_relative '../../../../apps/web/controllers/registrations/create'

RSpec.describe Web::Controllers::Registrations::Create, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it 'is successful' do
    skip 'Test is covered by Request test'

    response = action.call(params)
    expect(response[0]).to eq 200
  end
end
