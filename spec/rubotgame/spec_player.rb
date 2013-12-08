require 'minitest/spec'
describe Player do
  before(:each) do
    @config = Configuration.new
    @player = Player.new @config, 1, "#FF0000"
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
  it "can spawn" do
    @player.spawn [9,9]
    @player.bots.size.should eq 1
    @player.bots.first.should be_an_instance_of Bot
    @player.bots.first.location.should eq [9,9]
    @player.bots.first.hp.should eq @config.max_hp
    @player.bots.first.player_id.should eq @player.id
  end
  after(:each) do
    @player = nil
  end
end