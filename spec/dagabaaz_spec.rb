require "spec_helper"
require "rack/test"
describe Dagabaaz do
  include Rack::Test::Methods

  def app
    Dagabaaz.new
  end

  it "read and show cctray url from config.yml " do
    YAML.should_receive(:load_file).and_return({"url" => "abcd"})

    get '/'
    last_response.should be_ok
    last_response.body.should == "abcd"
  end
end