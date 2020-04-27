require 'gossip'

class ApplicationController < Sinatra::Base
  
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end

  get '/gossips/new/' do
    erb :new_gossip
  end

  post '/gossips/new/' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/'
  end

  get '/gossips/:id' do
    gossip = Gossip.find(params[:id].to_i)

    erb :show, locals: {gossip_author: gossip.author, gossip_content: gossip.content, number: params[:id].to_i}
  end

  get '/gossips/:id/edit/' do
    erb :edit
    # redirect '/'
  end

  post '/gossips/:id/edit/' do
    Gossip.update(params[:id].to_i, params["gossip_author_new"], params["gossip_content_new"])
    # redirect '/'
  end

end