require "spec_helper"
require "rack/test"
describe Dagabaaz do
  include Rack::Test::Methods

  def app
    Dagabaaz.new
  end

  it "read and show cctray url from config.yml " do
    YAML.should_receive(:load_file).and_return({"url" => "abcd"})
    pipelines = ["Pipeline 1", "Pipeline 1::Stage 1", "Pipeline 1::Stage 2", "Pipeline 2","Pipeline 2::Stage 1","Pipeline 2::Stage 1::Job 1" , "Pipeline 3", "Pipeline 3::Stage 1"].collect { |n| Pipeline.new n }
    project = Pipeline.new
    project.add pipelines
    Dagabaaz.any_instance.stub(:get_pipelines).and_return(project)

    get '/'

    last_response.should be_ok
    pending "because rack-test doesn't support assigns" do
      last_response.assigns(:project).should == project
    end
  end
end