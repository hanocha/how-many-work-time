require 'sinatra'
require 'sinatra/reloader'
require './main.rb'

get '/' do
  @test = 'Hello, Sinatra!!!'
  slim :index
end

get '/jobcan' do
  @j = Jobcan.new(@params[:code])
  slim :jobcan
end
