describe Bot do
  before(:each) do
    @bot = Bot.new
  end
  it "can be created with no arguments" do
    @bot.should be_an_instance_of Bot
  end
  after(:each) do
    @bot = nil
  end
end