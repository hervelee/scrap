require 'nokogiri'
require 'open-uri'


def get_name_depute
	page_web = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))
	object = page_web.xpath("/html/body/div[3]/div/div/section/div/article/div[3]/div/div[3]/div/ul/li/a")
	name_depute = []
	object[0..3].each {|names| name_depute << names.text}
	name_depute.length
end
# puts get_name_depute

def get_depute_email(url)
	page_web = Nokogiri::HTML(open(url))
	object = page_web.xpath("/html/body/div[3]/div/div/div/section[1]/div/article/div[3]/div/dl/dd/ul/li/a")
	email_depute = []
	object[0..3].each {|email| email_depute << email}	
	      email_depute.each do |mail|
			if mail.include?("mailto")
				email_depute << mail
			end
		end
		puts email_depute


end
 get_depute_email("http://www2.assemblee-nationale.fr/deputes/fiche/OMC_PA722038")

def get_depute_name_url
	page_web = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))
	web_urls = page_web.xpath("/html/body/div[3]/div/div/section/div/article/div[3]/div/div/div/ul/li/a")
	name_url= []
	web_urls[0..3].each {|url| name_url << url["href"]}
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
	puts tab_mail
	puts tab_name
	puts my_hash = Hash[tab_name.zip(tab_mail)]
end

perform
