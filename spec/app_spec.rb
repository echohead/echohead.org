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

  it 'has some coffeescript thing' do pending 'todo' end
end

