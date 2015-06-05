require 'pry'
require 'etsy'
require 'sinatra'
require "etsiest/version"

Etsy.api_key = ENV['ETSY_KEY']

module Etsiest

  class App < Sinatra::Base
    enable :logging
  
    get '/etsy/search' do
      Etsy.api_key = ENV['ETSY_KEY']
      response = Etsy::Request.get('/listings/active', :includes => ['Images', 'Shop'], :keywords => 'whiskey')
      a = JSON.parse(response.body)['results']
      a.to_json
    end

    get '/' do
    end


    run! if app_file == $0
  end
end

Etsy.api_key = ENV['ETSY_KEY']
response = Etsy::Request.get('/listings/active', :includes => ['Images', 'Shop'], :keywords => 'whiskey') = JSON.parse(response.body)['results']
response.map do |listing|
  listing_hash = {
    title: listing['title'],
    price: listing['price'],
    url: listing['url'],
    shop: listing['Shop']['shop_name'],
    image_url: listing['Images'][0]['url_fullxfull']
  }
  result << listing_hash
  binding.pry
end

binding.pry
