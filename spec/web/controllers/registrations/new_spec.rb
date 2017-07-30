require_relative '../../../../apps/web/controllers/registrations/new'

RSpec.describe Web::Controllers::Registrations::New do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to eq 200
  end
end
