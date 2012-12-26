class Project
  attr_accessor :pipelines
  def initialize
   @pipelines = []
  end
  def add(pipeline)
    if @pipelines.include?(pipeline)
      @pipelines.select{|p| p == pipeline}.first.addStages(pipeline.stages)
    else
      @pipelines.push pipeline
    end
  end
end