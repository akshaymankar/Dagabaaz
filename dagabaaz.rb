require "sinatra/base"
require File.dirname(__FILE__)+ "/boot"

class Dagabaaz < Sinatra::Base

  include PipelineHelper

  set :views, ["./app/views"]
  get '/' do
    config=YAML.load_file "config.yml"
    @project = get_pipelines(config["url"])
    haml :index
  end

  get '/pipelines' do
    config=YAML.load_file "config.yml"
    @project = get_pipelines(config["url"])

    @project.to_hash.to_json
  end
end