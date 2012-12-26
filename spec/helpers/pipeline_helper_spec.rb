require "rspec"

class DummyClass
  include PipelineHelper

end

describe PipelineHelper do
  before(:each) do
    @dummy = DummyClass.new
  end
  it "should return pipeline names" do
    @dummy.should_receive(:open).and_return(:url_handle)
    XmlSimple.should_receive(:xml_in).with(:url_handle).and_return({"Project" => [{"name" => "Project 1"},{"name" => "Project 2"},{"name" => "Project 3"}]})

    projects = @dummy.get_pipelines :url
    names = projects.collect do |project|
      project.name
    end

    ["Project 1","Project 2","Project 3"].each do |project_name|
      names.include?(project_name).should be_true
    end
  end
end