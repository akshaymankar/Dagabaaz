require "sinatra/base"
require File.dirname(__FILE__)+ "/boot"

class Dagabaaz < Sinatra::Base

  include PipelineHelper

  get '/' do
    config=YAML.load_file "config.yml"
    projects  = ""
    get_pipelines(config["url"]).each do |project|
      projects += project.name + "\n"
    end
    projects
  end
end