require "spec_helper"

describe Project do

  it { should respond_to :pipelines}

  let(:project) {Project.new}

  it "should add pipelines to itself" do
    pipeline = Pipeline.new("Pipeline")
    project.add(pipeline)

    project.pipelines.should include(pipeline)
  end

  it "should not add duplicate pipelines" do
    pipeline1 = Pipeline.new("Pipeline")
    pipeline2 = Pipeline.new("Pipeline")

    project.add(pipeline1)
    project.add(pipeline2)

    project.pipelines.count.should == 1
  end

  it "should merge stages of same pipeline whenever added" do
    pipeline1 = Pipeline.new("Pipeline::Stage1")
    pipeline2 = Pipeline.new("Pipeline::Stage2")

    project.add(pipeline1)
    project.add(pipeline2)

    project.pipelines.count.should == 1
    [pipeline1.stages.first, pipeline2.stages.first].each { |stage| project.pipelines.first.stages.should include(stage) }
  end
end