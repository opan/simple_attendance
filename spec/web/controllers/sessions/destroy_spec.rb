# frozen_string_literal: true

require_relative '../../../../apps/web/controllers/sessions/destroy'

RSpec.describe Web::Controllers::Sessions::Destroy, type: :action do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it 'success logout' do
    sign_in(action: action)
    response = action.call(params)
    expect(warden.user).to be_nil
    expect(response[1]['Location']).to eq '/sessions/new'
  end
end
