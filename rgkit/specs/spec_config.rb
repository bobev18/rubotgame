describe Configuration do
  before(:each) do
    @config = Configuration.new
  end
  it "can be created with no arguments, which loads default config" do
    @config.should be_an_instance_of Configuration
    @config.max_hp.should eq 50
    @config.max_turns.should eq 100
    @config.spawns.should eq [[7,1],[8,1],[9,1],[10,1],[11,1],[5,2],[6,2],[12,2],[13,2],[3,3],[4,3],[14,3],[15,3],[3,4],[15,4],[2,5],[16,5],[2,6],[16,6],[1,7],[17,7],[1,8],[17,8],[1,9],[17,9],[1,10],[17,10],[1,11],[17,11],[2,12],[16,12],[2,13],[16,13],[3,14],[15,14],[3,15],[4,15],[14,15],[15,15],[5,16],[6,16],[12,16],[13,16],[7,17],[8,17],[9,17],[10,17],[11,17]]
    @config.obstacles.should eq [[0,0],[1,0],[2,0],[3,0],[4,0],[5,0],[6,0],[7,0],[8,0],[9,0],[10,0],[11,0],[12,0],[13,0],[14,0],[15,0],[16,0],[17,0],[18,0],[0,1],[1,1],[2,1],[3,1],[4,1],[5,1],[6,1],[12,1],[13,1],[14,1],[15,1],[16,1],[17,1],[18,1],[0,2],[1,2],[2,2],[3,2],[4,2],[14,2],[15,2],[16,2],[17,2],[18,2],[0,3],[1,3],[2,3],[16,3],[17,3],[18,3],[0,4],[1,4],[2,4],[16,4],[17,4],[18,4],[0,5],[1,5],[17,5],[18,5],[0,6],[1,6],[17,6],[18,6],[0,7],[18,7],[0,8],[18,8],[0,9],[18,9],[0,10],[18,10],[0,11],[18,11],[0,12],[1,12],[17,12],[18,12],[0,13],[1,13],[17,13],[18,13],[0,14],[1,14],[2,14],[16,14],[17,14],[18,14],[0,15],[1,15],[2,15],[16,15],[17,15],[18,15],[0,16],[1,16],[2,16],[3,16],[4,16],[14,16],[15,16],[16,16],[17,16],[18,16],[0,17],[1,17],[2,17],[3,17],[4,17],[5,17],[6,17],[12,17],[13,17],[14,17],[15,17],[16,17],[17,17],[18,17],[0,18],[1,18],[2,18],[3,18],[4,18],[5,18],[6,18],[7,18],[8,18],[9,18],[10,18],[11,18],[12,18],[13,18],[14,18],[15,18],[16,18],[17,18],[18,18]]
    @config.board_size.should eq 18
    @config.spawns_per_player.should eq 5
    @config.spawn_cycle_turns.should eq 10
    @config.bump_damage.should eq 5
    @config.attack_damage_min.should eq 8
    @config.attack_damage_max.should eq 10
    @config.suicide_damage_min.should eq 15
    @config.suicide_damage_max.should eq 15
    @config.behaviour_on_error.should eq :defend
  end
  it "can be created with argument for config reference" do
    config = Configuration.new 'test'
    config.should be_an_instance_of Configuration
    config.max_hp.should eq 100
    config.max_turns.should eq 100
    config.spawns.should eq [[0, 0], [1, 0], [2, 0], [3, 0], [4, 0], [14, 18], [15, 18], [16, 18], [17, 18], [18, 18]]
    config.obstacles.should eq []
    config.board_size.should eq 18
    @config.spawns_per_player.should eq 5
    @config.spawn_cycle_turns.should eq 10
    config.bump_damage.should eq 1
    config.attack_damage_min.should eq 1
    config.attack_damage_max.should eq 1
    config.suicide_damage_min.should eq 1
    config.suicide_damage_max.should eq 1
    config.behaviour_on_error.should eq :suicide
  end
  after(:each) do
    @config = nil
  end
end