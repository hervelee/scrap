require 'nokogiri'
require 'open-uri'

## note !! : j'ai volontairement limité le scrapping à 10 names/emails parce que 576...mais si tu veux test check ligne 11 et ligne 32 et effface [0..9]


def get_name_depute
	page_web = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))
	object = page_web.xpath("/html/body/div[3]/div/div/section/div/article/div[3]/div/div[3]/div/ul/li/a")
	name_depute = []
	object[0..9].each {|names| name_depute << names.text}
	name_depute
end


def get_depute_email(url)
	page_web = Nokogiri::HTML(open(url))
	object = page_web.xpath("/html/body/div[3]/div/div/div/section[1]/div/article/div[3]/div/dl/dd/ul/li/a")
	email_depute = []
	tab = []
	object.each {|email| email_depute << email["href"]}			
		return  tab = email_depute.grep(/mailto/)
		
end

 

def get_depute_name_url
	page_web = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))
	web_urls = page_web.xpath("/html/body/div[3]/div/div/section/div/article/div[3]/div/div/div/ul/li/a")
	name_url= []
	web_urls[0..9].each {|url| name_url << url["href"]}
    name_url.map! do |i|
    i = "http://www2.assemblee-nationale.fr" + i 
    end
    return name_url
end

def perform
	page_web = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))
	tab_name = get_name_depute
	tab_mail = []	
	get_depute_name_url.each do |url_town|
	  tab_mail << get_depute_email(url_town)
	end
		 tab_mail
		 tab_name
		 my_hash = Hash[tab_name.zip(tab_mail)]
		 my_hash.each do |k,v|
				puts "#{k}: #{v}" 
		end
	
end

perform
