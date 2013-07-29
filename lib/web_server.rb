require 'sinatra/base'

class WebServer < Sinatra::Base
  get '/' do
    sleep 5
    "Hello World with value #{params[:value]}\n"
  end
end
