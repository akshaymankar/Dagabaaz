require "sinatra/base"
require File.dirname(__FILE__)+ "/boot"

class Dagabaaz < Sinatra::Base

  include PipelineHelper

  set :views, ["./app/views"]
  get '/' do
    config=YAML.load_file "config.yml"
    #pipelines  = ""
    @project = get_pipelines(config["url"])
    #@project.pipelines.each do |pipeline|
    #  pipelines += pipeline.name + "\n"
    #end
    #pipelines
    haml :index
  end
end