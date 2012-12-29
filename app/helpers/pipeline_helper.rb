module PipelineHelper
  def get_pipelines(url)
    xml = XmlSimple.xml_in(open(url))
    pipelines = xml["Project"].collect do |pipeline|
      Pipeline.new pipeline["name"]
    end

    project = Pipeline.new
    project.add pipelines
    project
  end
end
