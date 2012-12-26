require "sinatra/base"

class Dagabaaz < Sinatra::Base

  get '/' do
    config=YAML.load_file "config.yml"
    config["url"]
  end
end