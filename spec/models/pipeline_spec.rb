require "rspec"

describe Pipeline do
  it {should respond_to :name}
  it {should respond_to :stages}

  it "should be equal to other Pipeline if the names are same" do
    pipeline1 = Pipeline.new "p1"
    pipeline2 = Pipeline.new "p1"

    pipeline1.should eql(pipeline2)
    pipeline1.should == pipeline2
  end

  it "should also create and add subpipeline" do
    pipeline = Pipeline.new "Pipeline::Stage"

    pipeline.name.should == "Pipeline"

    stage = pipeline.stages.first
    stage.name.should == "Stage"
  end

  it "should create subpipelines at all stages" do
    pipeline = Pipeline.new "Pipeline::Stage::Job"

    pipeline.name.should == "Pipeline"

    stage = pipeline.stages.first
    stage.name.should == "Stage"

    job = stage.stages.first
    job.name.should == "Job"
  end

  it "should add stages from other pipeline" do
    pipeline1 = Pipeline.new "Pipeline:Stage1"
    pipeline2 = Pipeline.new "Pipeline:Stage2"
    pipeline2.stages.push(Pipeline.new "Stage3")

    pipeline1.add(pipeline2.stages)

    pipeline2.stages.each do |stage|
      pipeline1.stages.should include(stage)
    end
  end

  it "should _merge_ stages from other pipelines" do
    pipeline1 = Pipeline.new "Pipeline::Stage1::Job1"
    pipeline2 = Pipeline.new "Pipeline::Stage1::Job2"

    main = Pipeline.new
    main.add [pipeline1,pipeline2]

    main.stages.size.should == 1
    main.stages.first.stages.size.should == 1
    main.stages.first.stages.first.stages.size.should == 2
  end

  it "should strip name while saving " do
    pipeline1 = Pipeline.new " Abcd "
    pipeline1.name.should == "Abcd"
  end
end