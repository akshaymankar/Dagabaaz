require "./spec/spec_helper"

describe Pipeline do

  it "should create default pipeline" do
    pipeline = Pipeline.default
    pipeline.should_not be_nil
  end

  it "should be equal to other Pipeline if the names are same" do
    pipeline1 = Pipeline.new "name" => "p1"
    pipeline2 = Pipeline.new "name" => "p1"

    pipeline1.should eql(pipeline2)
    pipeline1.should == pipeline2
  end

  it "should also create and add subpipeline" do
    pipeline = Pipeline.new "name" => "Pipeline::Stage"

    pipeline.name.should == "Pipeline"

    stage = pipeline.stages.first
    stage.name.should == "Stage"
  end

  it "should create subpipelines at all stages" do
    pipeline = Pipeline.new  "name" => "Pipeline::Stage::Job"

    pipeline.name.should == "Pipeline"

    stage = pipeline.stages.first
    stage.name.should == "Stage"

    job = stage.stages.first
    job.name.should == "Job"
  end

  it "should add stages from other pipeline" do
    pipeline1 = Pipeline.new "name" => "Pipeline:Stage1"
    pipeline2 = Pipeline.new "name" => "Pipeline:Stage2"
    pipeline2.stages.push(Pipeline.new "name" => "Stage3")

    pipeline1.add(pipeline2.stages)

    pipeline2.stages.each do |stage|
      pipeline1.stages.should include(stage)
    end
  end

  it "should _merge_ stages from other pipelines" do
    pipeline1 = Pipeline.new "name" => "Pipeline::Stage1::Job1"
    pipeline2 = Pipeline.new "name"=> "Pipeline::Stage1::Job2"

    main = Pipeline.default
    main.add [pipeline1,pipeline2]

    main.stages.size.should == 1
    main.stages.first.stages.size.should == 1
    main.stages.first.stages.first.stages.size.should == 2
  end

  it "should strip name while saving " do
    pipeline1 = Pipeline.new "name" => " Abcd "
    pipeline1.name.should == "Abcd"
  end

  {
      "activity" => "Sleeping",
      "lastBuildStatus" => "Success",
      "lastBuildLabel" => "10",
      "lastBuildTime" => "2005-09-28T10:30:34.6362160+01:0",
      "nextBuildTime" => "2005-09-29T10:30:34.6362160+01:0",
      "webUrl" => "http://test/cctray/url"
  }.each do |attribute_name, attribute_value|
    it "should be created with '#{attribute_name}' attribute at leaf" do

      #main_pipeline = @dummy.get_pipelines :url

      pipeline = Pipeline.new "name" => "Pipeline1::Stage1::Job1", attribute_name => attribute_value
      stage = pipeline.stages.first
      job = stage.stages.first

      job.send(attribute_name.to_sym).should == attribute_value
    end
  end

end