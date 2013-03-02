require 'spec_helper'

describe 'the homepage' do
  before :all do @body = ok_body('/') end

  it 'has my name on it' do @body.should =~ /tim miller/ end
  it 'links to the music page' do @body.should link_to '/music' end
  it 'links to the sandbox' do @body.should link_to '/sandbox' end

  it 'shows the "about" post, for now' do
    @body.should =~ /about this site\.\.\./
  end
end


describe 'the music page' do
  before :all do @body = ok_body('/music') end

  it 'has songs on it' do pending 'todo' end
end

describe 'the sandbox' do
  before :all do @body = ok_body('/sandbox') end

  it 'should explain itself' do @body.should =~ /playing around with coffeescript/ end
  it 'should link to coffee source' do @body.should =~ /sandbox.coffee/ end
end

describe 'env' do
  it 'redirects to the bootstrap script on github' do
    resp = get '/env'
    resp.status.should == 302
    resp.headers['Location'].should =~ /raw.github.com\/echohead/
  end
end
