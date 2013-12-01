require 'minitest/spec'
describe Player do
  before(:each) do
    @config = Configuration.new
    @player = Player.new 1, "#FF0000"
  end
  it "can be created with no arguments" do
    @player.should be_an_instance_of Player
  end
  it "has the attributes" do
    @player.id.should eq 1
    @player.color.should eq "#FF0000"
    @player.bots.should eq []
    @player.source.should eq nil
  end
  after(:each) do
    @player = nil
  end
end