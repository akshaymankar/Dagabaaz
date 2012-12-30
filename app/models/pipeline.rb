class Pipeline
  attr_reader :name, :stages, :activity, :lastBuildStatus, :lastBuildLabel, :lastBuildTime, :lastBuildLabel, :nextBuildTime, :webUrl

  def initialize(args)
    pipeline_names = args["name"].split("::")
    @name = pipeline_names.first.strip
    pipeline_names.shift
    stage_name = pipeline_names.join("::")
    @stages = stage_name == "" ? [] : [ Pipeline.new(args.merge("name" => stage_name)) ]
    if @stages.empty?
      @activity = args["activity"]
      @lastBuildStatus = args["lastBuildStatus"]
      @lastBuildLabel = args["lastBuildLabel"]
      @lastBuildTime = args["lastBuildTime"]
      @nextBuildTime = args["nextBuildTime"]
      @webUrl = args["webUrl"]
    end
  end

  def self.default
    self.new("name" => "default")
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