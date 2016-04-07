require_relative './spec_helper'
require './models/init'

# describe 'Test root route' do
#   it 'should find the root route' do
#     get '/'
#     last_response.body.must_include 'ConfigShare'
#     last_response.status.must_equal 200
#   end
# end

describe 'Test creating configuration resources' do
  before do
    Project.dataset.delete
    Configuration.dataset.delete
  end

  it 'should catch duplicate config files within a project' do
    p = Project.create(name: 'class_demo')
    p.add_configuration(filename: 'filename.rb')
    duplicate_call = -> { p.add_configuration(filename: 'filename.rb') }
    _(duplicate_call).must_raise Sequel::UniqueConstraintViolation
  end
end

# describe 'Test idemptotent GET routes' do
#   before do
#
#   end
# end
