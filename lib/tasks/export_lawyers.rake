require 'rubygems'
require 'nokogiri'   
require 'open-uri'
require 'csv'
require 'mechanize'

namespace :export do
    desc "Will out put CSV's for Subscribers"
    task :lawyers => :environment do
        
        agent = Mechanize.new
        
        mech_page = agent.get("http://www.aaml.org/members/arizona")

        CSV.open("#{Rails.root}/public/lawyers.csv", "w+") do |csv|
            page = mech_page.parser
            page.css('tr').each do |scrape|
                name = scrape.css('.views-field-field-profile-fname-value-1').text
                city = scrape.css('.views-field-city').text
                state = scrape.css('.views-field-field-state-value').text
                links = scrape.css('a')
                urls = links.map { |link| link['href']}
                url = urls.first

                profile_page = agent.get(page.css('.contact-btn').last.attributes['href'].value)

                profile_page_parsed = profile_page.parser

                blurb = profile_page_parsed.css('.details')[0].text
                legal_orgs = profile_page_parsed.css('.details')[1].text
                presentations = profile_page_parsed.css('.details')[2].text
                authors = profile_page_parsed.css('.details')[3].text

                street_address = profile_page_parsed.css('.street-address').text

                phone = profile_page_parsed.css('.tel')[0].text

                website = profile_page_parsed.css('.website-btn').last.attributes['href'].text




                csv << [name, city, state, url, blurb, legal_orgs, street_address, phone, website]
            end
        end
    end
end