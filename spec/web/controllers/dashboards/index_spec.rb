# frozen_string_literal: true

require_relative '../../../../apps/web/controllers/dashboards/index'

RSpec.describe Web::Controllers::Dashboards::Index, type: :action do
  let(:action) { described_class.new }
  let(:params) { {} }

  context 'without sign in' do
    it 'is failed' do
      expect do
        sign_in(action: action, user: nil)
        action.call(params)
      end.to throw_symbol(:warden)
    end
  end
end
