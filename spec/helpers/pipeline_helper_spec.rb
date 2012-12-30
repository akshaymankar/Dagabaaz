require "rspec"

class DummyClass
  include PipelineHelper

end

describe PipelineHelper do
  before(:each) do
    @dummy = DummyClass.new
    @dummy.should_receive(:open).and_return(:url_handle)
  end

  it "should return project with all pipelines" do
    xml_to_hash = {"Project" => [{"name" => "Pipeline1::Stage1"}, {"name" => "Pipeline1::Stage2"}, {"name" => "Pipeline2::Stage1"}]}

    XmlSimple.should_receive(:xml_in).with(:url_handle).and_return(xml_to_hash)

    main_pipeline = @dummy.get_pipelines :url
    names = main_pipeline.stages.collect { |pipeline| pipeline.name }

    ["Pipeline1","Pipeline2"].each do |pipeline_name|
      names.should include(pipeline_name)
    end
  end

  it "should fetch project with all details" do
    project_data = {
        "name" => "Pipeline",
        "activity" => "Sleeping",
        "lastBuildStatus" => "Success",
        "lastBuildLabel" => "10",
        "lastBuildTime" => "2005-09-28T10:30:34.6362160+01:0",
        "nextBuildTime" => "2005-09-29T10:30:34.6362160+01:0",
        "webUrl" => "http://test/cctray/url"
    }
    xml_to_hash ={ "Project" => [project_data] }

    XmlSimple.should_receive(:xml_in).with(:url_handle).and_return(xml_to_hash)

    main_pipeline = @dummy.get_pipelines :url
    pipeline = main_pipeline.stages.first

    project_data.each do |attribute_name, attribute_value|
      pipeline.send(attribute_name).should == attribute_value
    end
  end


end