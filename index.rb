require 'sinatra'
require 'sinatra/reloader'
require './main.rb'

get '/' do
  slim :index
end

get '/jobcan' do
  begin
    @j = Jobcan.new(@params[:code])
    slim :jobcan
  rescue
    slim :error
  end
end
