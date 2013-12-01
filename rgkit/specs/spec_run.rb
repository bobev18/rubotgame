describe Run do
  before(:each) do
    @run = Run.new
  end
  it "can be created with no arguments" do
    @run.should be_an_instance_of Run
  end
  after(:each) do
    @run = nil
  end
end