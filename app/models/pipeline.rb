class Pipeline
  attr_reader :name, :stages

  def initialize(name = "Default")
    pipeline_names = name.split("::")
    @name = pipeline_names.first.strip
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

  def add(more_stages)
    more_stages.each do |stage|
      if @stages.include?(stage)
        @stages.find{|p| p == stage}.add(stage.stages)
      else
        @stages.push stage
      end
    end
  end

end