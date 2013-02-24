require 'spec_helper'


describe 'post: makeshift notifications with gmail' do
  before :all do @body = ok_body('/post/makeshift_notifications_with_gmail') end

  it 'mentions ssmtp' do @body.should =~ /ssmtp/ end
end

describe 'post: test-driven blog development illustrating its own creation' do
  pending 'todo'
end
