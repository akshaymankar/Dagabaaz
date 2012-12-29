require "spec_helper"
require "rack/test"
describe Dagabaaz do
  include Rack::Test::Methods

  def app
    Dagabaaz.new
  end

  it "should send cctray url to view" do
    YAML.should_receive(:load_file).and_return({"url" => "abcd"})
    pipeline_names = ["Pipeline 1", "Pipeline 1::Stage 1", "Pipeline 1::Stage 2", "Pipeline 2", "Pipeline 2::Stage 1", "Pipeline 2::Stage 1::Job 1", "Pipeline 3", "Pipeline 3::Stage 1"]
    pipelines = pipeline_names.collect { |n| Pipeline.new "name" => n }
    project = Pipeline.default
    project.add pipelines
    Dagabaaz.any_instance.stub(:get_pipelines).and_return(project)

    get '/'

    last_response.should be_ok
    pending "because rack-test doesn't support assigns" do
      last_response.assigns(:project).should == project
    end
  end
end