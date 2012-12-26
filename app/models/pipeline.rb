class Pipeline
  attr_accessor :name
  attr_accessor :stages

  def initialize(name = "Default")
    pipeline_names = name.split("::")
    @name = pipeline_names.first
    pipeline_names.shift
    stages = pipeline_names.join("::")
    @stages = stages == "" ? [] : [ Pipeline.new(stages) ]
  end

  def eql?(other)
    return false if !other.instance_of? Pipeline
    return false if !other.respond_to? :name
    return false if self.name != other.name
    true
  end

  alias == eql?

  def addStages(stages)
    @stages.push(*stages)
  end

end