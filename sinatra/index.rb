require 'sinatra'
require 'sinatra/reloader'
require './main.rb'

get '/' do
  slim :index
end

get '/profile' do
  begin
    @j = HowManyWorkTime.new(@params[:code])
    slim :profile
  rescue
    slim :error
  end
end
