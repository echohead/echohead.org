require 'spec_helper'

describe 'the echohead app' do

  it 'has an index page' do
    get '/'
    last_response.should be_ok, last_response.body
    last_response.body.should =~ /tim miller/
  end

end


describe 'the music page' do

  it 'has songs on it' do
    pending 'todo'
  end

end
