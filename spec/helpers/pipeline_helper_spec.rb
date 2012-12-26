require "rspec"

class DummyClass
  include PipelineHelper

end

describe PipelineHelper do
  before(:each) do
    @dummy = DummyClass.new
  end
  it "should return project with all pipelines" do
    @dummy.should_receive(:open).and_return(:url_handle)
    xml_to_hash = {"Project" => [{"name" => "Pipeline1::Stage1"}, {"name" => "Pipeline1::Stage2"}, {"name" => "Pipeline2::Stage1"}]}
    XmlSimple.should_receive(:xml_in).with(:url_handle).and_return(xml_to_hash)

    project = @dummy.get_pipelines :url
    names = project.pipelines.collect { |pipeline| pipeline.name }

    ["Pipeline1","Pipeline2"].each do |pipeline_name|
      names.should include(pipeline_name)
    end
  end
end