require 'pry'
require 'etsy'
require 'sinatra'
require "etsiest/version"

Etsy.api_key = ENV['ETSY_KEY']

module Etsiest

  class App < Sinatra::Base
    enable :logging
  
    get '/etsy_search' do
      @search = params['q']
      if @search == ""
        "You didn't type in a search term."
        erb :nosearch
      elsif @search == nil
        erb :nosearch
      else
        @results = []
        response = Etsy::Request.get('/listings/active', :includes => ['Images', 'Shop'], :keywords => "#{@search}")
        response = JSON.parse(response.body)['results']
        response.map do |listing|
          listing_hash = {
            title: listing['title'],
            price: listing['price'],
            url: listing['url'],
            shop: listing['Shop']['shop_name'],
            image_url: listing['Images'][0]['url_170x135']
          }
          @results << listing_hash
        end
        erb :etsy
      end
    end
    
    run! if app_file == $0
  end
end



binding.pry
