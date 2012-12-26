require 'xmlsimple'
require 'open-uri'

module PipelineHelper
  def get_pipelines(url)
    xml = XmlSimple.xml_in(open(url))
    xml["Project"].collect do |project|
     project["name"]
    end
  end
end