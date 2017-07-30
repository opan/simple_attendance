require 'spec_helper'
require_relative '../../../../apps/web/controllers/sessions/new'

describe Web::Controllers::Sessions::New do
  let(:action) { Web::Controllers::Sessions::New.new }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)
    response[0].must_equal 200
  end
end
