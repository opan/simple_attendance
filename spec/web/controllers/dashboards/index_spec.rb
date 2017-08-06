require_relative '../../../../apps/web/controllers/dashboards/index'

RSpec.describe Web::Controllers::Dashboards::Index do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)
    expect(response[0]).to eq 200
  end
end
