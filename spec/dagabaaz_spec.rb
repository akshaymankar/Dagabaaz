require "spec_helper"
require "rack/test"
describe Dagabaaz do
  include Rack::Test::Methods

  def app
    Dagabaaz.new
  end

  it "read and show cctray url from config.yml " do
    YAML.should_receive(:load_file).and_return({"url" => "abcd"})
    Dagabaaz.any_instance.stub(:get_pipelines).and_return(["Project 1","Project 2","Project 3"])

    get '/'

    last_response.should be_ok
    last_response.body.should == "Project 1\nProject 2\nProject 3\n"
  end
end