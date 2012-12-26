require 'xmlsimple'
require 'open-uri'

module PipelineHelper
  def get_pipelines(url)
    xml = XmlSimple.xml_in(open(url))
    pipelines = xml["Project"].collect do |pipeline|
      Pipeline.new pipeline["name"]
    end

    project = Project.new
    pipelines.each do |pipeline|
      project.add pipeline
    end
    project
  end
end