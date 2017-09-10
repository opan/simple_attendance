# frozen_string_literal: true

require_relative '../../../../apps/web/controllers/sessions/unauthenticated'

RSpec.describe Web::Controllers::Sessions::Unauthenticated, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it 'get expected response' do
    sign_in(action: action, user: nil)
    env['warden.options'] = {}
    response = action.call(params)
    expect(response[1]['Location']).to eq '/sessions/new'
    expect(action.exposures[:flash][:alert]).to eq 'You must login to continue'
  end
end
