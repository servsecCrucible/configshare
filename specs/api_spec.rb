require_relative './spec_helper'

describe 'Test root route' do
  it 'should find the root route' do
    get '/'
    _(last_response.body).must_include 'ConfigShare'
    _(last_response.status).must_equal 200
  end
end
