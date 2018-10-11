require 'nokogiri'
require 'open-uri'


def get_name(page)
    web_object = page.css("a.currency-name-container.link-secondary")
    name_coin = []
    web_object.each do |link|
      name_coin << link.text
    end
    return name_coin
end

#get_name("https://coinmarketcap.com/all/views/all/")

def get_price(page)
    web_object = page.css("a.price")
    price_coin = []
    web_object.each do |link|
      price_coin << link["data-usd"]
    end
    return price_coin
end

#get_price("https://coinmarketcap.com/all/views/all/")


def perform
  while(true) 
  page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
  coin = get_name(page)
  price = get_price(page)
  my_coin_hash = Hash[coin.zip(price)]
  my_coin_hash.each do |key, value|
    puts "Le cours du #{key} est de $#{value}"
  end
sleep (10)
end
end

perform