require 'nokogiri'
require 'open-uri'

def get_the_email_of_a_townhal_from_its_webpage(url_town) 
	page_web = Nokogiri::HTML(open(url_town))
	e_mail_mairie = page_web.css("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]")
	return e_mail_mairie.text
end
# puts  get_the_email_of_a_townhal_from_its_webpage ("http://annuaire-des-mairies.com/95/bethemont-la-foret.html")

def get_the_name_of_a_townhal_from_its_webpage(url_town) 
	page_web = Nokogiri::HTML(open(url_town))
	name_mairie = page_web.css("/html/body/div/main/section[1]/div/div/div/h1")
	return name_mairie.text
end
# puts get_the_name_of_a_townhal_from_its_webpage ("http://annuaire-des-mairies.com/95/vaureal.html")


def get_all_the_urls_of_val_doise_townhalls 
	page_web = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
	web_urls = page_web.css("a")
	array_urls = []
	web_urls.each do |link|
	  array_urls << link["href"]
	end
	tab_urls = array_urls.grep(/.*95/)
		tab_urls.map do |i|
			i[0]= "" + "http://annuaire-des-mairies.com"
		end
	return tab_urls
end
# puts get_all_the_urls_of_val_doise_townhalls ("http://annuaire-des-mairies.com/val-d-oise.html")

def perform
	
	tabmail = []
	tab_name = []
	get_all_the_urls_of_val_doise_townhalls.each do |url_town|
		tabmail << get_the_email_of_a_townhal_from_its_webpage(url_town)
	end
	get_all_the_urls_of_val_doise_townhalls.each do |url_town|
		tab_name << get_the_name_of_a_townhal_from_its_webpage(url_town)
	end
	return my_hash = Hash[tab_name.zip(tabmail)]
end 
  puts perform
