module PipelineHelper
  def get_pipelines(url)
    xml = XmlSimple.xml_in(open(url))
    pipelines = xml["Project"].collect do |pipeline|
      Pipeline.new "name" => pipeline["name"]
    end

    project = Pipeline.default
    project.add pipelines
    project
  end
end
